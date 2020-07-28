package test
{
    import classes.popUpAddGuest;
    
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;
    
    import mx.core.Application;
    
    public class AddGuestTest extends TestCase
    {
    	import mx.managers.PopUpManager;
        public function AddGuestTest(methodName : String){
            super(methodName);
        }
            
        public static function suite():TestSuite{
    		var suite:TestSuite = new TestSuite();
    		suite.addTest(new AddGuestTest("testPopupGuest"));
    		return suite;
		}

        
        public function testPopupGuest():void {
        	var popUp:popUpAddGuest;
        	var window:Application = new Application();
        	
    		popUp = popUpAddGuest(PopUpManager.createPopUp(window, popUpAddGuest, true));
			assertNotNull(popUp);
			
    		
		}
		
		public function testGetMealCodeFromRemote():void {
			
		}

    }
}
