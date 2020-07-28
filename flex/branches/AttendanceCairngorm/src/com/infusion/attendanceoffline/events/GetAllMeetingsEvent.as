package com.infusion.attendanceoffline.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetAllMeetingsEvent extends CairngormEvent
	{
		public static var GET_ALL_MEETINGS:String = "getAllMeetings";

		public var clubID:int;
		
		/**
		 * Constructor.
		 */
		public function GetAllMeetingsEvent(clubID:int)
		{
			super( GET_ALL_MEETINGS );
			this.clubID = clubID;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new GetAllMeetingsEvent(clubID);
		}	
	}
	
}