package com.infusion.attendanceoffline.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class GetMealCodesEvent extends CairngormEvent
	{
		public static var MEAL_CODES:String = "mealcodes";

		public var clubID:int = 0;
		
		/**
		 * Constructor.
		 */
		public function GetMealCodesEvent(clubID:int, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(MEAL_CODES, bubbles, cancelable);
			this.clubID = clubID;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new GetMealCodesEvent(clubID, true, true);
		}	
	}
	
}