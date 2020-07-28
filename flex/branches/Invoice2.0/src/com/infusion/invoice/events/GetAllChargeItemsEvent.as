package com.infusion.invoice.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetAllChargeItemsEvent extends CairngormEvent
	{
		public static var GET_ALL_CHARGE_ITEMS:String = "getAllChargeItems";

		public var region:int;
		
		/**
		 * Constructor.
		 */
		public function GetAllChargeItemsEvent(region:int, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( GET_ALL_CHARGE_ITEMS, bubbles, cancelable );
			this.region = region;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new GetAllChargeItemsEvent(region, true, true);
		}	
	}
	
}