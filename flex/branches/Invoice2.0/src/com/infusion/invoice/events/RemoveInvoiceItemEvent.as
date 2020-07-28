package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	
	import flash.events.Event;

	public class RemoveInvoiceItemEvent extends CairngormEvent
	{
		public static var REMOVE_INVOICE_ITEM:String = "removeInvoiceItem";

		public var chargeItem:ChargeItem;
		public var invoiceGroupID:int;
		
		/**
		 * Constructor.
		 */
		public function RemoveInvoiceItemEvent(chargeItem:ChargeItem, invoiceGroupID:int, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( REMOVE_INVOICE_ITEM, chargeItem, invoiceGroupID, bubbles, cancelable );
			this.chargeItem = chargeItem;
			this.invoiceGroupID = invoiceGroupID;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new RemoveInvoiceItemEvent(chargeItem, invoiceGroupID, true, true);
		}	
	}
	
}