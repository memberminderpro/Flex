package com.infusion.attendanceoffline.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.infusion.attendanceoffline.events.GetAllMeetingsEvent;
	import com.infusion.attendanceoffline.events.GetMealCodesEvent;
	import com.infusion.attendanceoffline.events.LoginEvent;
	import com.infusion.attendanceoffline.services.delegates.ClubMeetingDelegate;
	
	import mx.controls.Alert;
	import mx.rpc.events.*;
	
	public class InitSQLTablesCommand extends CommandBase 
	{
	  	public function InitSQLTablesCommand(){	 
		}
	
		/**
		 * Called onOpenDatabase: at startup, or at db location change
		 */ 
		override public function execute( event:CairngormEvent ):void {
			var delegate:ClubMeetingDelegate = new ClubMeetingDelegate(this);
			trace("Init Local Database");
			delegate.login(username, password);
		}
	
		override public function result( event : Object ):void {				
			//store the resulting data in the model locator
			_model.attendanceConfig.clubID = event.result as int;
			trace("Logged in with club id "+_model.attendanceConfig.clubID);
			Alert.show("Logged in with club id "+_model.attendanceConfig.clubID);
			
			//1. Now getAllMeetings
			var getMeetingEvent:GetAllMeetingsEvent = new GetAllMeetingsEvent(_model.attendanceConfig.clubID); 
			trace("Retrieving all Meetings ");
			CairngormEventDispatcher.getInstance().dispatchEvent( getMeetingEvent );
			
			//2. Now getMealCodes
			var getMealCodesEvent:GetMealCodesEvent = new GetMealCodesEvent(_model.attendanceConfig.clubID); 
			trace("Retrieving all Meal Codes ");
			CairngormEventDispatcher.getInstance().dispatchEvent( getMealCodesEvent );
		}
	
	}

}