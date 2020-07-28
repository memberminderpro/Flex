package com.infusion.attendanceoffline.model.dtos
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	[Bindable]
	public class AttdConfig
	{
		//converted
		private  var dsnPostfix:String = ".CFC.ClubAttendanceFLEX";
		private  var endpointPostfix:String = "/flex2gateway";
		public var clubID:int;
		public var destination:String = "Rotary";
		public var endPoint:String = "http://www.directory-online.com";
		public var fullDestination:String = destination + dsnPostfix;
		public var fullEndPoint:String    = endPoint + endpointPostfix;
		public var userName:String = "mike7710@mikethacker.com";
		public var password:String = "gofish";
		
		public var _userNm:String;
		public var _userPw:String;
		public var _clubID:int;
		public var _path:String;
		public var _DirPath:String;
		public var _custom:Boolean;
		public var _dataFlag:Boolean;
		public var cfgConn:SQLConnection;
		public var CfgSetupStmt:SQLStatement = new SQLStatement();
		public var CreateSetupStmt:SQLStatement = new SQLStatement();
		public var SetupStmt:SQLStatement = new SQLStatement();
		public var DeleteSetupStmt:SQLStatement = new SQLStatement();
		public var SaveSetupStmt:SQLStatement = new SQLStatement();
		public var UpdateStmt:SQLStatement = new SQLStatement();
		public var cfgFile:File;
		public var configXML:XML = <AttendanceConfig>
    				<ServerUrl>http://www.directory-online.com</ServerUrl>
    				<Destination>Rotary</Destination>  <!-- this could also just be combined with the ServerUrl /-->
   					<Icon>http://www.directory-online.com/images/Rotary.jpg or whatever</Icon>
    				<GroupName>Rotary Attendance</GroupName>
    				<Stylesheet>http://www.directory-online.com/rotary.css</Stylesheet> 
					</AttendanceConfig>;
		private var sqlUpdate:String = "UPDATE setup SET ClubID = ";
		private var sqlSetup:String =
			"CREATE TABLE IF NOT EXISTS setup (" +
			" Idx INTEGER PRIMARY KEY AUTOINCREMENT, " +
			" ClubID INTEGER, " +
			" Endpoint TEXT, " +
			" DSN TEXT, " +
			" UserID TEXT, " +
			" UserPW TEXT, " + 
			" DirPath TEXT, " + 
			" Custom INTEGER );";
		private var sqlSave:String = "INSERT INTO setup(ClubID, Endpoint, DSN, " + 
				"UserID, UserPW, DirPath, Custom ) " +
				"VALUES(:ClubID, :Endpoint, :DSN, :UserID, :UserPW, :DirPath, :Custom)";
		public function AttdConfig()	// 
		{
			cfgFile = File.documentsDirectory.resolvePath("attendancecfg.db");
			_path = cfgFile.nativePath;
			cfgConn = new SQLConnection();
			cfgConn.addEventListener(SQLEvent.OPEN, initHandler);
			cfgConn.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			cfgConn.openAsync(cfgFile);
			// Connection is open...
			function initHandler(e:SQLEvent):void
			{
				// Creat Statement
				CreateSetupStmt.sqlConnection = cfgConn;
				CreateSetupStmt.text = sqlSetup;
				CreateSetupStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
				CreateSetupStmt.addEventListener(SQLEvent.RESULT, CreateSetupResult);
				// Set up Setup statement
				SetupStmt.sqlConnection = cfgConn;
				CfgSetupStmt.sqlConnection = cfgConn;
				CfgSetupStmt.text = "SELECT * FROM setup;";
				CfgSetupStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
				CfgSetupStmt.addEventListener(SQLEvent.RESULT, SetupDataResult);
				// Delete statement
				DeleteSetupStmt.sqlConnection = cfgConn;
				DeleteSetupStmt.text = "DELETE FROM setup;";
				DeleteSetupStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
				DeleteSetupStmt.addEventListener(SQLEvent.RESULT, DeleteCfg);
				// Save Statement
				SaveSetupStmt.sqlConnection = cfgConn;
				SaveSetupStmt.text = sqlSave;
				SaveSetupStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
				SaveSetupStmt.addEventListener(SQLEvent.RESULT, SaveSetupResult); 
				// Update
				UpdateStmt.sqlConnection = cfgConn;
				UpdateStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
				UpdateStmt.addEventListener(SQLEvent.RESULT, UpdateComplete);
				dispatchEvent(new Event(Event.OPEN));
			}
		}
		
		public function shutdownHook():void {
			cfgConn.close();
		}
		public function CreateTable():void
		{
			CreateSetupStmt.execute();
		}
		private function CreateSetupResult(e:SQLEvent):void
		{
			CfgSetupStmt.execute();
		}
		// Handler
		private	function SetupDataResult(e:SQLEvent):void			// Data read
		{
			var result:SQLResult;
			var path:String;
			
			_dataFlag = false;
			result = CfgSetupStmt.getResult();
			if(result.data == null) {
				//new setup?  Apply defaults
				resetToDefaults();
			} else {
				destination = result.data[0].DSN;
				endPoint = result.data[0].Endpoint;
				_userNm = result.data[0].UserID;
				_userPw = result.data[0].UserPW;
				_clubID = result.data[0].ClubID;
				_DirPath = result.data[0].DirPath;
				_dataFlag = true;
			}
			dispatchEvent(new Event(Event.CONNECT));
		}
		/**
		 * Overrides from server
		 */
		public function setDefaultConfig(cfg:XML):void {
			if(cfg != null && cfg != "") 
				configXML = cfg;
		}
		public function resetToDefaults():void {
			endPoint = configXML.ServerUrl;
			destination = configXML.Destination;
			_userNm = "";
			_userPw = "";
			_custom = false;
			_DirPath = File.documentsDirectory.nativePath; //TODO is this correct?
			_dataFlag = false; //TODO need this?
		}
		// Setters & Getters
		public function get DataFlag():Boolean
		{
			return _dataFlag;
		}

		public function set userNm(s:String):void
		{
			_userNm = s;
		}
		public function get userNm():String
		{
			return _userNm;
		}
		public function set userPw(s:String):void
		{
			_userPw = s;
		}
		public function get userPw():String
		{
			return _userPw;
		}

		public function set DirPath(s:String):void
		{
			_DirPath = s;
		}
		public function get DirPath():String
		{
			return _DirPath;
		}
		public function set custom(b:Boolean):void
		{
			_custom = b;	
		}
		public function get custom():Boolean
		{
			return _custom;
		}
		//Called only if DB file location NOT changed
		public function UpdateCfg():void
		{
			UpdateStmt.text = sqlUpdate + _clubID;
			UpdateStmt.execute();
		}
		private function UpdateComplete(e:SQLEvent):void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		/*
			Save Setup via deletion
			1) Delete old values
			2) Insert new values
		*/
		public function SaveCFG():void
		{	
			DeleteSetupStmt.execute();
		}
		/*
				Successful deletion of setup table
				Fill in new values
		*/
		private	function DeleteCfg(e:SQLEvent):void
		{
			SaveSetupStmt.parameters[":ClubID"] = _clubID; 
			SaveSetupStmt.parameters[":Endpoint"] = endPoint; 
			SaveSetupStmt.parameters[":DSN"] = destination;
			SaveSetupStmt.parameters[":UserID"] = _userNm;
			SaveSetupStmt.parameters[":UserPW"] = _userPw;
			SaveSetupStmt.parameters[":DirPath"] = _DirPath;
			SaveSetupStmt.parameters[":Custom"] = _custom;
				// Save new record
			SaveSetupStmt.execute();
		}
				// Local Handler
		private	function SaveSetupResult(e:SQLEvent):void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		private function errorHandler(e:SQLErrorEvent):void
		{
			var err:String;
			err = e.error.message;
		}
	}
}