package com.infusion.attendanceoffline.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.attendanceoffline.model.dtos.Meeting;
	
	import flash.events.Event;

	public class SelectMeetingEvent extends CairngormEvent
	{
		public static var SELECT_MEETING:String = "selectMeeting";

		public var meeting:Meeting;
		
		/**
		 * Constructor.
		 */
		public function SelectMeetingEvent(meeting:Meeting)
		{
			super(SELECT_MEETING);
			this.meeting = meeting;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new SelectMeetingEvent(meeting);
		}	
	}
	
}