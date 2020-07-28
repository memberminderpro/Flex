package com.infusion.attendanceoffline.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.attendanceoffline.events.GetAllMeetingsEvent;
	import com.infusion.attendanceoffline.model.dtos.Meeting;
	import com.infusion.attendanceoffline.services.delegates.ClubMeetingDelegate;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.*;
	
	public class GetAllMeetingsCommand extends CommandBase
	{
	  	public function GetAllMeetingsCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var clubID:int = (event as GetAllMeetingsEvent).clubID;
			
			var delegate:ClubMeetingDelegate = new ClubMeetingDelegate(this);
			delegate.getAllMeetingsForClub(clubID);
		}
	
		override public function result( event : Object ):void {				
			_model.allMeetings = event.result as ArrayCollection;
			trace("Received meetings: "+_model.allMeetings.length);
			trace(_model.allMeetings);
			for(var i:int=0; i < _model.allMeetings.length; i++) { 
				var o:Object = (_model.allMeetings.getItemAt(i));
				var m:Meeting = new Meeting(_model.allMeetings.getItemAt(i));
				trace((m));
			}
			//TODO handle deleting of closed meetings
			
		}

	}

}