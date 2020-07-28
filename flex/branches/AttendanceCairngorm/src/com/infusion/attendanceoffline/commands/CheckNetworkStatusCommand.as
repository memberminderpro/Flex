package com.infusion.attendanceoffline.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.attendanceoffline.events.GetAllMeetingsEvent;
	import com.infusion.attendanceoffline.model.dtos.Meeting;
	import com.infusion.attendanceoffline.services.delegates.ClubMeetingDelegate;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.*;
	
	public class CheckNetworkStatusCommand extends CommandBase
	{
	  	public function CheckNetworkStatusCommand() {
	  		/*	 
	  		headRequest.method = "HEAD";
 			headRequest.url = config.endPoint+"/"+config.dsn; 
 			//first clean up old one
 			if(connectTest != null) {
 				connectTest.removeEventListener(HTTPStatusEvent.HTTP_STATUS, connectHttpStatusHandler);
 				connectTest.removeEventListener(Event.COMPLETE, connectCompleteHandler);
 				connectTest.removeEventListener(IOErrorEvent.IO_ERROR, connectErrorHandler); 
 			}
 			connectTest = new URLLoader(headRequest);
 			connectTest.addEventListener(HTTPStatusEvent.HTTP_STATUS, connectHttpStatusHandler);
 			connectTest.addEventListener(Event.COMPLETE, connectCompleteHandler);
 			connectTest.addEventListener(IOErrorEvent.IO_ERROR, connectErrorHandler); 
 			connectTest.
 			*/
		}
	
		override public function execute( event:CairngormEvent ):void {
			var clubID:int = (event as GetAllMeetingsEvent).clubID;
			
			var delegate:ClubMeetingDelegate = new ClubMeetingDelegate(this);
			delegate.getAllMeetingsForClub(clubID);
		}
	
		override public function result( event : Object ):void {				

		}
		
		private function connectHttpStatusHandler(event:*=null):void{
 			if (event.status == "0" ? setNetworked(false):setNetworked(true));
 			
		}
		private function connectErrorHandler(event:IOErrorEvent):void{
 			setNetworked(false);
		}
		private function connectCompleteHandler(event:Event):void{
		 	setNetworked(true);
		}

	}

}