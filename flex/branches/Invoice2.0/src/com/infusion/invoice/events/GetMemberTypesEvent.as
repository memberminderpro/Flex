package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class GetMemberTypesEvent extends CairngormEvent
	{
		public static var GET_MEMBER_TYPES:String = "getMemberTypes";
		
		public var clubID:int;
		
		/**
		 * Constructor.
		 */
		public function GetMemberTypesEvent(clubID:int, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(GET_MEMBER_TYPES, bubbles, cancelable);
			this.clubID = clubID;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new GetMemberTypesEvent(clubID, true, true);
		}	
	}
	
}