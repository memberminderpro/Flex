package com.infusion.attendanceoffline.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class MessageEvent extends CairngormEvent
	{
		public static var GET_MESSAGE:String = "getMessage";

		public var type:String;
		
		/**
		 * Constructor.
		 */
		public function MessageEvent(type:String)
		{
			super( GET_MESSAGE );
			this.type = type;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new MessageEvent(type);
		}	
	}
	
}