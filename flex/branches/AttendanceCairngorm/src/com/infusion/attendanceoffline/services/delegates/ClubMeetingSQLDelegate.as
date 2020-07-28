package com.infusion.attendanceoffline.services.sql
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;

	public class LocalDatabaseDelegate
	{
		public function LocalDatabaseDelegate( responder : IResponder )
		{		
			this.responder = responder;
		}
		
		private var responder : IResponder;
		private var sqlConnection:SQLConnection;
		
		private var sqlCreateMemberTable:String = 
			"CREATE TABLE IF NOT EXISTS members (" + 
			" Idx INTEGER PRIMARY KEY AUTOINCREMENT, " + " UserID INTEGER, " +
			" UserName TEXT(50), " +" Attended TEXT, " +
			" MemberID INTEGER, " + " MemberTypeID INTEGER, " +
			" ClubAttendanceID INTEGER, " +	" ClubMeetingID INTEGER, " +
			" MemberType TEXT(50), " +	" Notes TEXT(50), " +
			" Counts INTEGER, " + " Makeup INTEGER, " +
			" Excused INTEGER, " +	" Rof85 INTEGER, " +
			" MealCode INTEGER DEFAULT 0, " + " GuestCode INTEGER, " +
			" Date TEXT(30) )"; 
			
		 private var sqlCreateMeetingTable:String = 
			"CREATE TABLE IF NOT EXISTS	meeting (" +
			" ClubMeetingID PRIMARY KEY, " + " Attended INTEGER, " +
			" Exempt INTEGER, " + " MakeUp INTEGER, " +
			" ClubID INTEGER, " + " Total INTEGER, " +
			" ClubMeeting TEXT, " +	" ClubName TEXT, " +
			" IsOpen TEXT, " + " MeetingDate TEXT, " +
			" LastSaved TEXT, " + " LastModified TEXT, " +
			" Dirty INTEGER );"; 	// Local Value
			
		private var sqlSelectAllMeetings:String = "SELECT * FROM meeting ";
  
         public function openLocalDatabase(dbFile:File):void { 
         	//Close previous connection
         				
	         // create new sqlConnection  
	         sqlConnection = new SQLConnection();
	         sqlConnection.addEventListener(SQLEvent.OPEN, onDatabaseOpen);
	         sqlConnection.addEventListener(SQLErrorEvent.ERROR, errorHandler);
	  
	         // get current dir   
	        // var dbFile:File = File.applicationStorageDirectory.resolvePath("sampleDB.db");
	  
	         // open database,If the file doesn't exist yet, it will be created
	         sqlConnection.openAsync(dbFile);
         }
  
         // connect and init database/table
         private function onDatabaseOpen(event:SQLEvent):void
         {
            //1. Create tables if needed
            var sqlStat:SQLStatement = new SQLStatement();
            sqlStat.sqlConnection = sqlConnection;

            sqlStat.text = sqlCreateMeetingTable;
            sqlStat.addEventListener(SQLEvent.RESULT, createMeetingTableResult);
            sqlStat.addEventListener(SQLErrorEvent.ERROR, dbError);
            sqlStat.execute(-1, responder);
  			
  			//2. Load data from DB into DataModel

			
         }
         private function createMeetingTableResult(e:SQLEvent):void
		 {
			 getAllMeetings();
		 }
		 public function getAllMeetings():void {
		 	var getAllMeetingsStmt:SQLStatement = new SQLStatement();
		 	getAllMeetingsStmt.sqlConnection = sqlConnection;

            getAllMeetingsStmt.text = sqlSelectAllMeetings;
            getAllMeetingsStmt.execute(-1, responder);
		 }
         
         private function dbError(e:Event):void {
         	Alert.show("DB error: "+e);
         }
	}

}