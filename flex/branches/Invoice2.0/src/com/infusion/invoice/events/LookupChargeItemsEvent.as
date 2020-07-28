package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	
	import flash.events.Event;

	public class LookupChargeItemsEvent extends CairngormEvent
	{
		public static var LOOKUP_CHARGE_ITEMS:String = "lookupChargeItems";

		public var invoiceGroupID:int;
		
		/**
		 * Constructor.
		 */
		public function LookupChargeItemsEvent(invoiceGroupID:int, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( LOOKUP_CHARGE_ITEMS, bubbles, cancelable );
			this.invoiceGroupID = invoiceGroupID;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new LookupChargeItemsEvent(invoiceGroupID, true, true);
		}	
	}
	
}