package com.infusion.invoice.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetChargeTypesEvent extends CairngormEvent
	{
		public static var GET_CHARGE_TYPES:String = "getChargeTypes";
		
		/**
		 * Constructor.
		 */
		public function GetChargeTypesEvent(bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(GET_CHARGE_TYPES, bubbles, cancelable);
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new GetChargeTypesEvent(true, true);
		}	
	}
	
}