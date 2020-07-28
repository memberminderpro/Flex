package com.infusion.attendanceoffline.services.sql
{
	import mx.rpc.IResponder;
	import com.adobe.cairngorm.business.ServiceLocator;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.AbstractOperation;
	
	import flash.data.SQLConnection;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;

	public class SqlDelegate
	{
		public function SqlDelegate( responder : IResponder )
		{		
			this.service = ServiceLocator.getInstance().getRemoteObject( "helloWorldService" );
			this.responder = responder;
		}
		
		public function getMessage(name:String) : void
		{			
			var call : Object = service.sayHello(name);
			call.addResponder( responder );
		}
	
		private var responder : IResponder;
		private var service : Object;
		
		 
         private var conn:SQLConnection;
         private var initComplete:Boolean = false;
         private var sqlStat:SQLStatement;
  
         public function openDatabaseConnection():void{
  
	         // create new sqlConnection  
	         sqlConnection = new SQLConnection();
	         sqlConnection.addEventListener(SQLEvent.OPEN, onDatabaseOpen);
	         sqlConnection.addEventListener(SQLErrorEvent.ERROR, errorHandler);
	  
	         // get current dir   
	         var dbFile:File = File.applicationStorageDirectory.resolvePath("sampleDB.db");
	  
	         // open database,If the file doesn't exist yet, it will be created
	         sqlConnection.openAsync(dbFile);
         }
  
         // connect and init database/table
         private function onDatabaseOpen(event:SQLEvent):void
         {
             // init sqlStatement objects
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
				
             sqlStat = new SQLStatement();
             sqlStat.sqlConnection = conn;
             var sql:String =         "CREATE TABLE IF NOT EXISTS user (" +
                                                     "    id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                                                     "    name TEXT, " +
                                                     "    password TEXT" +
                                                     ")";
                 sqlStat.text = sql;
                 sqlStat.addEventListener(SQLEvent.RESULT, statResult);
                 sqlStat.addEventListener(SQLErrorEvent.ERROR, createError);
                 sqlStat.execute();   
                 
                 //more
                 		// SQL statements
		private var selectStmt:SQLStatement = new SQLStatement();
		private var memberStmt:SQLStatement = new SQLStatement();
		private var selectAllStmt:SQLStatement = new SQLStatement();
		private var selectNoneStmt:SQLStatement = new SQLStatement();
		private var CreateMemberStmt:SQLStatement = new SQLStatement();
		private var CreateMeetingStmt:SQLStatement = new SQLStatement();
		
		
		private var sqlMember:String = 
			"CREATE TABLE IF NOT EXISTS members (" + 
			" Idx INTEGER PRIMARY KEY AUTOINCREMENT, " +
			" UserID INTEGER, " +
			" UserName TEXT(50), " +
			" Attended TEXT, " +
			" MemberID INTEGER, " +
			" MemberTypeID INTEGER, " +
			" ClubAttendanceID INTEGER, " +
			" ClubMeetingID INTEGER, " +
			" MemberType TEXT(50), " +
			" Notes TEXT(50), " +
			" Counts INTEGER, " +
			" Makeup INTEGER, " +
			" Excused INTEGER, " +
			" Rof85 INTEGER, " +
			" MealCode INTEGER DEFAULT 0, " +
			" GuestCode INTEGER, " +
			" Date TEXT(30) )" 
		private var sqlMeeting:String = 
			"CREATE TABLE IF NOT EXISTS	meeting (" +
			" ClubMeetingID PRIMARY KEY, " +
			" Attended INTEGER, " +
			" Exempt INTEGER, " +
			" MakeUp INTEGER, " +
			" ClubID INTEGER, " +
			" Total INTEGER, " +
			" ClubMeeting TEXT, " +
			" ClubName TEXT, " +
			" IsOpen TEXT, " +
			" MeetingDate TEXT, " +
			" LastSaved TEXT, " +
			" LastModified TEXT, " +
			" Dirty INTEGER );"; 	// Local Value
			
			//Config
			config = new LoadCfg();
			config.addEventListener(Event.OPEN, cfgCreated);
			config.addEventListener(Event.COMPLETE, cfgSaved);
			config.addEventListener(Event.CHANGE, cfgUpdated);
			config.addEventListener(Event.CONNECT, cfgDataAvail);
			
			//TODO needs a shutdown hook to be called
			config.shutdownHook();
			if(sqlConn != null) sqlConn.close(); 
			
			                   
         }
         
         		private function cfgCreated(e:Event):void
		{
			config.CreateTable();
			initNetworking();
		}
		private function cfgDataAvail(e:Event):void
		{
			//No directory path set
			if(config.DirPath == null)
			{
				db1File = File.documentsDirectory;
				config.DirPath = db1File.nativePath;
			}
			if(config.DataFlag == false)
			{
				Message.text = "Setup Required";
				//navTab.selectedIndex = 3;
			}
			else
			{
//				userNm = config.userNm;
//				userPw = config.userPw;
				endPoint = config.endPoint;
				clubID = config.clubID;
				dsn = config.dsn;
			}
			checkNetworkConnection();
			dirSelected();
		}
		private function cfgSaved(e:Event):void
		{
			Message.text = "Setup Saved";
			checkNetworkConnection();
		}
		private function cfgUpdated(e:Event):void
		{
			Message.text = "Setup Updated";
			checkNetworkConnection();
			sqlLogin();
		}
		private function setSQLStatements():void
		{
			// Create Meeting Table
			CreateMeetingStmt.sqlConnection = sqlConn;
			CreateMeetingStmt.text = sqlMeeting;
			CreateMeetingStmt.addEventListener(SQLEvent.RESULT, createMeetingResult);
			CreateMeetingStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			// Create Member Table
			CreateMemberStmt.sqlConnection = sqlConn;
			CreateMemberStmt.text = sqlMember;
			CreateMemberStmt.addEventListener(SQLEvent.RESULT, createResult);
			CreateMemberStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			// Set up member statements
			memberStmt.sqlConnection = sqlConn;
			memberStmt.addEventListener(SQLEvent.RESULT, memberResult);
			memberStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			// Set up Select from meetin
			selectStmt.sqlConnection = sqlConn;
			selectStmt.text = "SELECT * FROM meeting ";		// Get all
			selectStmt.addEventListener(SQLEvent.RESULT, selectResult);
			selectStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			// Set up Select All
			selectAllStmt.sqlConnection = sqlConn;
			selectAllStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			selectAllStmt.addEventListener(SQLEvent.RESULT, selectBulkResult);
			// Set up Select None
			selectNoneStmt.sqlConnection = sqlConn;
			selectNoneStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			selectNoneStmt.addEventListener(SQLEvent.RESULT, selectBulkResult);	
		}
		// Open database
		private function dirSelected():void
		{
			sqlConn = new SQLConnection();
			sqlConn.addEventListener(SQLEvent.OPEN, initHandler);
			sqlConn.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			db1File.nativePath = config.DirPath;
			db1File = db1File.resolvePath("attendance.db");
			if(sqlConn.connected) sqlConn.close();
			//Alert.show("Opened new database at: "+db1File.nativePath);
			sqlConn.openAsync(db1File);
			// Connection is open...
			function initHandler(e:SQLEvent):void
			{
				setSQLStatements();
				clubAttendance.endpoint = config.endPoint + "/flex2gateway";
				clubMeeting.endpoint = config.endPoint + "/flex2gateway";
				clubAttendance.source = config.dsn + ".CFC.ClubAttendanceFLEX";
				clubMeeting.source = config.dsn + ".CFC.ClubMeetingFLEX";
				//btnLoad.enabled = true;
				// Create Members
				CreateMemberStmt.execute();
				// Create Meeting
				CreateMeetingStmt.execute();
				//Load from Local
				//loadDB(); -- done automatically when create Meeting fires
			}
		}
		
		private function newDirectory(newDirPath:String):void
		{	
			sqlConn.close();			// Close current
			db1File.nativePath = newDirPath;
			dirSelected();
		} 
		
				private function saveCFG(updatedConfig:LoadCfg):void
		{
//			config.dsn = destination.text;
//			config.endPoint = urlText.text;
//			config.clubID = clubID;
//			config.userNm = txName.text;
//			config.userPw = txPW.text;; 
//			config.DirPath = FilePath;
//			btnLoad.enabled = true;
			if(config.DirPath != updatedConfig.DirPath) {
				updatedConfig.clubID = config.clubID;
				config = updatedConfig;
				config.UpdateCfg();
				
			} else { //full save.  TODO move DB?
				config = updatedConfig;
				config.SaveCFG();
			}
			newDirectory(config.DirPath);
			
			
		}
		private function createResult(e:SQLEvent):void
		{
			//Message.text = "";
		}
		private function createMeetingResult(e:SQLEvent):void
		{
			//Message.text = "";
			loadDB();
		}
		private function errorHandler(e:SQLErrorEvent):void
		{
			Message.text = e.error.message;
			CursorManager.removeBusyCursor();
			Alert.show(e.toString());
			log.error(e.error.getStackTrace());
		}	
		
		/*
			Load from local database
		*/
		private function loadDB():void
		{
			CursorManager.setBusyCursor();
			selectStmt.execute();
			mealCodes = mealCodesDB.getMealCodes();
			mealCodes.enableAutoUpdate();
			menuCodeEditor.bindMealCodes(mealCodes);
		}
		
		/** After select * from meeting; (localdb) **/
		private function selectResult(e:SQLEvent):void
		{
			var result:SQLResult = selectStmt.getResult();
			var resultLen:int;
			var i:int;
			var m:Members;
			var row:Object;
			
			CursorManager.removeBusyCursor();
			
			if(result.data == null)
			{
				Message.text = "No Local Data Available. Sync with server.";
				arLocal = new Array();
				dgLocal.dataProvider = arLocal;
				dgLocal.invalidateList();
				if(dgMembers != null)
				{
					acMembers = new ArrayCollection();
					dgMembers.dataProvider = acMembers;
					dgMembers.invalidateList();
				}
				checkNetworkConnection();
				btnLoad.enabled = true;
			}
			else
			{
				//Message.text = "";
				arLocal = result.data;
				dgLocal.dataProvider = arLocal;
				dgLocal.invalidateList();

			}
		}
		
		
		/*
			Item Meetings from dgMeeting - itemClick
		*/
		private function itemMeeting(e:Event):void
		{
			var sql:SQLStatement = new SQLStatement();
			var result:SQLResult;
			var d:Date;
			var s:String;
			var i:int;
			
			clubMeetingID = e.currentTarget.selectedItem.ClubMeetingID;
			sql.sqlConnection = sqlConn;
			sql.text = "SELECT Dirty, LastModified, LastSaved From meeting WHERE ClubMeetingID = '" + 
						clubMeetingID + "';";
			sql.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			sql.addEventListener(SQLEvent.RESULT, itemMeetingResult);
			sql.execute();
			return;
			// Handle Result
			function itemMeetingResult(e:SQLEvent):void
			{
				result = sql.getResult();
				if(result.data.length > 0)	// Have values
				{
					//TODO does this do anything? (inherited from Bruce)
					s = result.data[0].LastSaved;
					d = new Date(s);
					s = dtFormat.format(d);
					s = result.data[0].LastModified;
					d = new Date(s);
					s = dtFormat.format(d);
					i = result.data[0].Dirty;
				}
			}
		}
		/*
			Insert meeting list to local Database
		*/
		private function meetingInsert(obj:Object, downloadmembers:Boolean):void
		{
			var sqlCmd:String = "INSERT INTO meeting(ClubMeetingID, " +
								"ClubMeeting, " + "ClubName, " + 
								"Attended, " + "Exempt, " + "MakeUp, " +
								"Total, " + "MeetingDate, " + "IsOpen, " +
								"LastSaved, " + "LastModified, " + "Dirty ) ";
			var sqlVal:String;
			var sql:SQLStatement;
			var sqlError:Boolean = false;	// Optimistic
			var args:Object = {ClubMeetingID:0};
			var today:String = dtFormat.format(new Date());
			
			sql = new SQLStatement;
			sql.sqlConnection = sqlConn;
			sql.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			sql.addEventListener(SQLEvent.RESULT, insertSync);
			sqlVal = "VALUES('" + obj.ClubMeetingID + "'," +
						"'" + obj.ClubMeeting + "'," +
						"'" + obj.ClubName + "', " + 
						"'" + obj.Attended + "', " +
						"'" + obj.Exempt + "', " +
						"'" + obj.MakeUp + "', " +
						"'" + obj.Total + "', " +
						"'" + obj.MeetingDate + "', " +
						"'" + obj.IsOpen + "', " +
						"'" + today + "', " +
						"'" + today + "', " +
						"'" + 0 + "')";		// Dirty flag
			sql.text = sqlCmd + sqlVal;
			sql.execute();
			
			// Local result;
			function insertSync(e:SQLEvent):void
			{
				Message.text = "";
			}
		
			if(downloadmembers) {
				Message.text = "Downloading "+obj.ClubMeeting;
				args.ClubMeetingID = obj.ClubMeetingID;
				clubAttendance.Download(args);
			}
		}
		/*
			Update meeting in local Database
		*/
		private function meetingUpdate(obj:Object):void
		{
			//First update matching meeting in GUI via arLocal
			var i:int;
			for(i=0; i < arLocal.length; i++) {
 				if(arLocal[i].ClubMeetingID == obj.ClubMeetingID) {
 					arLocal[i] = obj;
 					dgLocal.invalidateList();
 				}
 			}
			
			//Then write to DB
			//TODO handle this atomically
			var today:String = dtFormat.format(new Date());
			if(obj.LastModified == null) {
				obj.LastModified = today;
			}
			if(obj.LastSaved == null) {
				obj.LastSaved = today;
			}
			if(obj.Dirty == null) {
				obj.Dirty = 0;
			}
			var sqlCmd:String = "UPDATE meeting SET "+
								"ClubMeeting='" +obj.ClubMeeting + 
								"' , ClubName= '" + obj.ClubName +
								"' , Attended='"  + obj.Attended +
								"' , Exempt='"    + obj.Exempt +
								"' , MakeUp='"    + obj.MakeUp +
								"' , Total='"     + obj.Total  +
								"' , MeetingDate='" + obj.MeetingDate +
								"' , IsOpen='"   + obj.IsOpen +
								"' , LastSaved='" + obj.LastSaved +
								"' , LastModified='" + obj.LastModified +
								"' , Dirty='"     + obj.Dirty +
								"' WHERE ClubMeetingID = '"+obj.ClubMeetingID +"' ";
			var sqlVal:String;
			var sql:SQLStatement;
			
			
			sql = new SQLStatement;
			sql.sqlConnection = sqlConn;
			sql.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			sql.addEventListener(SQLEvent.RESULT, updateSync);
			sql.text = sqlCmd;
			sql.execute();
			
			// Local result;
			function updateSync(e:SQLEvent):void
			{
				Message.text = "";
			}
			
			//TODO Now update data model directly
	
		}
         private function statResult(event:SQLEvent):void
         {
                 // refresh data
             var sqlresult:SQLResult = sqlStat.getResult();                             
                 if(sqlresult.data == null){
                         getResult();
                         return;                                     
                 }
                 datafiled.dataProvider = sqlresult.data;
         }
         // get data
         private function getResult():void{
                 var sqlquery:String = "SELECT * FROM user"
                 excuseUpdate(sqlquery);                             
         }
         private function createError(event:SQLErrorEvent):void
         {
             trace("Error code:", event.error.code);
             trace("Details:", event.error.message);
         }
         private function errorHandler(event:SQLErrorEvent):void
         {
             trace("Error code:", event.error.code);
             trace("Details:", event.error.message);
         }
         // update
         private function excuseUpdate(sql:String):void{
                 sqlStat.text = sql;
                 sqlStat.execute();
         }                     
         // insert
         private function insertemp():void{
                 var sqlupdate:String = "Insert into user(id,name,password) values('" +
                                 name.text +
                                 "','" +
                                 password.text  +
                                 "')";
         debug.text+=sqlupdate+"\n"                                             
                 excuseUpdate(sqlupdate)
         }
         // delete
         private function deleteemp():void{
                 var sqldelete:String = "delete from user where id='" +
                                 datafiled.selectedItem.id +
                                 "'";
                 excuseUpdate(sqldelete);
                 debug.text+=sqldelete+"\n"                             
         }
	}

}