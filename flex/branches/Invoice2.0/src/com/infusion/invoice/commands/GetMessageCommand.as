package com.infusion.attendanceoffline.commands
{
	import mx.rpc.IResponder;
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import mx.rpc.events.*;
	import mx.controls.Alert;
	import com.asfusion.helloworld.cairngorm.business.MessageDelegate;
	import com.asfusion.helloworld.cairngorm.event.MessageEvent;
	import com.asfusion.helloworld.cairngorm.model.HelloWorldModelLocator;
	import com.asfusion.helloworld.cairngorm.vo.Message;
	
	public class GetMessageCommand implements ICommand, IResponder
	{
	  	public function GetMessageCommand()
		{	 
		}
	
		public function execute( event:CairngormEvent ):void {
			   		
			var delegate:MessageDelegate = new MessageDelegate(this);
			delegate.getMessage((event as MessageEvent).name);
		}
	
		public function result( event : Object ):void {				

			var model:HelloWorldModelLocator = HelloWorldModelLocator.getInstance();
			//store the message in the model locator
			model.message = event.result as Message;
			
			/* I think it is best not to use these static variables to indicate current state, 
			but since this example is supposed to follow Cairngorm's methodology, I am using
			them here */
			model.viewState = HelloWorldModelLocator.SHOW_MESSAGE;
			
			//TODO NEW
					//from clubMeeting.Login
		private function clubMeetingHandler(e:ResultEvent):void
		{
			var i:int, len:int;
			var rmtMsg:RemotingMessage;
    		var msgOp:String;
    		var id:int;		// Club ID returned from login
    		
    		rmtMsg = e.token.message as RemotingMessage;
    		msgOp = rmtMsg.operation;
    		if(msgOp == "Lookup") // Contains all meetings for the club
    		{
				lookupMeetingHandler(e.result as ArrayCollection);
				loadDB();			// Load to local;
				
				//Message.text = "";
			}
			if(msgOp == "Login") 	// Returns with Club ID
			{
				clubID = e.result as int;
				modeOnLine = true;
				if(clubID > 0)
				{
					Message.text = "Finding club "+clubID+"...";
					config.clubID = clubID;
					config.UpdateCfg();
					clubMeeting.MealCode(clubID);
				}
				else
				{
					Message.text = "Login failed...";
				}
			}
			if(msgOp == "MealCode")
			{
				var mcArray:ArrayCollection = e.result as ArrayCollection;
				if(mcArray != null && mcArray.length > 0) {
					mealCodesDB.clearMealCodes();
					for(i=0; i<mcArray.length; i++) {
						mealCodesDB.addMealCode(mcArray[i].MealCode, mcArray[i].MealCodeID);
					}
				}
				mealCodes = mealCodesDB.getMealCodes();
				mealCodes.enableAutoUpdate();
				menuCodeEditor.bindMealCodes(mealCodes);
			} else if(msgOp == "View") {
				//got single meeting "refresh dirty" from server
				var viewArray:ArrayCollection = e.result as ArrayCollection;
				if(viewArray != null && viewArray.length == 1) {
					var mID:int = viewArray[0].ClubMeetingID;
					meetingUpdate(viewArray[0]); //should only be one
					//now delete and re-download for this meeting
					deleteMembersForMeeting(mID);
					var args:Object = {ClubMeetingID:mID};
					clubAttendance.Download(args);
				}
			}
		}
		}
	
		public function fault( event : Object ) : void
		{
			var faultEvent : FaultEvent = FaultEvent( event );
			Alert.show( "We couldn't contact the server to say Hello :(","Error" );
		}
	}

}