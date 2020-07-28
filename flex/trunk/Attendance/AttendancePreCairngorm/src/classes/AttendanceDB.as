package classes
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ArrayUtil;
	/**
	 * Handles only MealCodes table for now.  
	 * TODO migrate other db tables under attendance to here
	 * */
	[Bindable]
	public class AttendanceDB
	{
		private var mealCodeArray:ArrayCollection = new ArrayCollection();
		private var cfgConn:SQLConnection;
		private var CfgSetupStmt:SQLStatement = new SQLStatement();
		private var CreateSetupStmt:SQLStatement = new SQLStatement();
		private var SetupStmt:SQLStatement = new SQLStatement();
		private var DeleteSetupStmt:SQLStatement = new SQLStatement();
		private var SaveSetupStmt:SQLStatement = new SQLStatement();
		private var UpdateStmt:SQLStatement = new SQLStatement();
		private var _clubID:int = 1234;
		private var cfgFile:File;
		private var _path:String;
		private var _DirPath:String;
		private var sqlUpdate:String = "UPDATE mealcodes SET MealCode = ";
		private var sqlSetup:String =
			"CREATE TABLE IF NOT EXISTS mealcodes (" +
			" MealCodeID INTEGER PRIMARY KEY, " +
			" MealCode TEXT);";
		private var sqlSave:String = "INSERT INTO mealcodes(MealCodeID, MealCode) " +
				"VALUES(:MealCodeID, :MealCode)";
		public function AttendanceDB()	// 
		{
			setupDB();
			
		}
		public function setupDB():void {
			cfgFile = File.documentsDirectory.resolvePath("attendance.db");
			_path = cfgFile.nativePath;
			cfgConn = new SQLConnection();
			cfgConn.addEventListener(SQLEvent.OPEN, initHandler);
			cfgConn.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			cfgConn.open(cfgFile);
			// Connection is open...
			function initHandler(e:SQLEvent):void
			{
				// Create Table if needed
				CreateSetupStmt.sqlConnection = cfgConn;
				CreateSetupStmt.text = sqlSetup;
				CreateSetupStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
				CreateSetupStmt.addEventListener(SQLEvent.RESULT, CreateSetupResult);
				// Set up Setup statement
				SetupStmt.sqlConnection = cfgConn;
				CfgSetupStmt.sqlConnection = cfgConn;
				CfgSetupStmt.text = "SELECT * FROM mealcodes;";
				CfgSetupStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
				CfgSetupStmt.addEventListener(SQLEvent.RESULT, MealCodesDataResult);
				// Delete statement
				DeleteSetupStmt.sqlConnection = cfgConn;
				DeleteSetupStmt.text = "DELETE FROM mealcodes;";
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
				
				createTable();
				dispatchEvent(new Event(Event.OPEN));
			}
		}
		public function shutdownHook():void {
			cfgConn.close();
		}
		public function createTable():void
		{
			//DeleteSetupStmt.execute();
			CreateSetupStmt.execute();
		}
		private function CreateSetupResult(e:SQLEvent):void
		{
			CfgSetupStmt.execute();
		}
		
			// Handler
		private	function MealCodesDataResult(e:SQLEvent):void			
		{
			var result:SQLResult;
			var path:String;
			
			result = CfgSetupStmt.getResult();
			if(result.data != null)
			{
				mealCodeArray = new ArrayCollection(ArrayUtil.toArray(result.data));
				var o:Object = new Object();
				o.MealCode = "";
				o.MealCodeID = 0;
				mealCodeArray.addItemAt(o, 0);
				
			}
			dispatchEvent(new Event(Event.CONNECT));
		}
		// Setters & Getters
		
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
			/* SaveSetupStmt.parameters[":ClubID"] = _clubID; 
			SaveSetupStmt.parameters[":Endpoint"] = _endPoint; 
			SaveSetupStmt.parameters[":DSN"] = _dsn;
			SaveSetupStmt.parameters[":UserID"] = _userNm;
			SaveSetupStmt.parameters[":UserPW"] = _userPw;
			SaveSetupStmt.parameters[":DirPath"] = _DirPath;
			 */
			 //TODO SaveSetupStmt.parameters[":Custom"] = _custom;
				// Save new record
			//SaveSetupStmt.execute();
		}
				// Local Handler
		private	function SaveSetupResult(e:SQLEvent):void
		{
			//dispatchEvent(new Event(Event.COMPLETE));
		}
		private function errorHandler(e:SQLErrorEvent):void
		{
			var err:String;
			err = e.error.message;
		}
		public function clearMealCodes():void {
			DeleteSetupStmt.execute();
		}
		public function addMealCode(label:String, value:int):void {
			SaveSetupStmt.parameters[":MealCodeID"] = value;
			SaveSetupStmt.parameters[":MealCode"] = label;
			SaveSetupStmt.execute();
		}
		
		public function getMealCodes():ArrayCollection
		{
			mealCodeArray.removeAll(); //clear first
			CfgSetupStmt.execute(); //to MealCodesDataResult
			
			return mealCodeArray;
		}
	}
}