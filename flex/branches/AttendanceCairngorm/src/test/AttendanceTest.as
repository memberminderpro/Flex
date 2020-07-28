package test
{
    import classes.AttendanceDB;
    
    import flash.data.SQLConnection;
    import flash.data.SQLStatement;
    import flash.events.SQLErrorEvent;
    import flash.events.SQLEvent;
    import flash.data.SQLSchemaResult;
    import flash.filesystem.File;
    
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;
    
    import mx.collections.ArrayCollection;
    
    public class MemSelTest extends TestCase
    {
    	private var cfgFile:File;
    	private var cfgConn:SQLConnection;
    	private var sqlSave:String = "INSERT INTO mealcodes(MealCodeID, MealCode) " +
				"VALUES(:MealCodeID, :MealCode)";
		private var saveStmt:SQLStatement = new SQLStatement();
		private var deleteStmt:SQLStatement = new SQLStatement();
    	public function setUpLocal():void {
    		cfgFile = File.documentsDirectory.resolvePath("attendance.db");
			cfgConn = new SQLConnection();
			cfgConn.addEventListener(SQLEvent.OPEN, initHandler);
			cfgConn.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			cfgConn.open(cfgFile);

			//init sql statements
			saveStmt.sqlConnection = cfgConn;
			saveStmt.text = sqlSave;
			saveStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			
			
			deleteStmt.sqlConnection = cfgConn;
			deleteStmt.text = "DELETE FROM mealcodes;";
			deleteStmt.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			
			
    	}
        public function MemSelTest(methodName : String){
            super(methodName);
            setUpLocal();
        }
        
        private function errorHandler(e:SQLErrorEvent):void
		{
			fail(e.error.message);
		}
		
		private function initHandler(e:SQLEvent):void
		{
			var evt:String;
			evt = e.toString();
		}
            
        public static function suite():TestSuite{
    		var suite:TestSuite = new TestSuite();
    		suite.addTest(new MemSelTest("testGetMealCodeArray"));
    		return suite;
		}

        
        public function testGetMealCodeArray():void {
    		var db:AttendanceDB = new AttendanceDB();
    		var clubID:int = 1234;
    		//setup data independently in database
    		try {
    			//deleteStmt.addEventListener(SQLEvent.RESULT, deleteHandler);
    			deleteStmt.execute();
    			
    			saveStmt.addEventListener(SQLEvent.RESULT, insertHandler);
    			assertTrue(saveStmt.sqlConnection.connected);
 				saveStmt.parameters[":MealCodeID"] = 0;
				saveStmt.parameters[":MealCode"] = "Clown Paid";
				saveStmt.execute();
				saveStmt.clearParameters();
				saveStmt.parameters[":MealCodeID"] = 1;
				saveStmt.parameters[":MealCode"] = "Elephant Paid";
				saveStmt.execute();
				saveStmt.clearParameters();
				saveStmt.parameters[":MealCodeID"] = 3;
				saveStmt.parameters[":MealCode"] = "Guest Paid";
				saveStmt.execute();
				function insertHandler(e:SQLEvent):void
				{
			
				}

    		} finally {
    			cfgConn.close();
    		}
    		//read back
    		var mealCodes:ArrayCollection = db.getMealCodes();
    		assertEquals("Expecting MealCodes", 3, mealCodes.length);
    		assertTrue( mealCodes.getItemAt(0).hasOwnProperty("MealCode"));
    		
		}
		
		public function testGetMealCodeFromRemote():void {
			
		}

    }
}
