package test
{
    
    import InfusionGrp.SelectedMember;
    
    import com.adobe.serialization.json.JSON;
    
    import flash.events.*;
    
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;
    
    import mx.collections.ArrayCollection;
    import mx.controls.Alert;
    import mx.events.*;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.mxml.RemoteObject;
    
    public class MemSelTest extends TestCase
    {
    	private var gotResult:Boolean = false;
    	private var ac:ArrayCollection = new ArrayCollection();
    	private var _memberSelected:RemoteObject;
    	public var _dsn:String = "Rotary";
		[Bindable]
		//public var _endPoint:String = "http://www.directory-online.com/flex2gateway"
		public var _endPoint:String = "http://67.199.65.125/flex2gateway/"; //Changed
    	
        public function MemSelTest(methodName : String){
            super(methodName);
            setUpLocal();
        }
        
        private function setUpLocal():void {
        	_memberSelected = new RemoteObject;
        	_memberSelected.destination="ColdFusion";
        	_memberSelected.addEventListener(FaultEvent.FAULT, errorHandler);
        	_memberSelected.addEventListener(ResultEvent.RESULT, memberSelectedCFC);
        	_memberSelected.source = _dsn + ".CFC.ChargeMemberSelectedDAO";
        	_memberSelected.endpoint = _endPoint;
        	
        }
        private function memberSelectedCFC(e:ResultEvent):void
		{
			Alert.show(e.message.toString(), "Response MemberSelectedCFC");
			gotResult = true;
		}
        
        
        private function errorHandler(e:Event):void
		{
			fail(e.toString());
		}

            
        public static function suite():TestSuite{
    		var suite:TestSuite = new TestSuite();
    		suite.addTest(new MemSelTest("testSaveQ"));
    		return suite;
		}

        
        public function testSaveQ():void {

			var i:int, len:int;
			var dataSend:String;	
			var _arSend:Array; 
			
			_arSend = new Array();
			
			//setup ac array of SelectedMember s
			var member:SelectedMember = new SelectedMember(null);
			member.IsSelected = true;
			member.UserName = "Bagshawe, Nick";
			member.UserID = 77101740;
			member.ChargeItemID = 131;
			member.ChargeMemberSelectedID = 0;
			ac.addItem(member);
			
			len = ac.length;
			
			Alert.show("len="+ac.length, "Called memQ");
			for(i=0; i<len; i++)
			{
					//ac[i].ChargeItemID = id;
					_arSend.push(ac[i]);  
			}
			Alert.show(_arSend.length+"", "Sending memQ");
			if(_arSend.length > 0)
			{
				dataSend = JSON.encode(_arSend);
				Alert.show(dataSend, "Sending SaveQ");
				_memberSelected.SaveQ(dataSend);
			}
			
			//assertTrue(gotResult);
			//return dataSend;
		}
		
		public function testGetMealCodeFromRemote():void {
			
		}

    }
}
