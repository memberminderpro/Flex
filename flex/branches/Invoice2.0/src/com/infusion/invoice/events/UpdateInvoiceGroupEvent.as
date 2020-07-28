package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	
	import flash.events.Event;

	public class UpdateInvoiceGroupEvent extends CairngormEvent
	{
		public static var UPDATE_INVOICE_GROUP:String = "updateInvoiceGroup";

		public var invoiceGroup:InvoiceGroup;
		
		/**
		 * Constructor.
		 */
		public function UpdateInvoiceGroupEvent(invoiceGroup:InvoiceGroup, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( UPDATE_INVOICE_GROUP, bubbles, cancelable );
			this.invoiceGroup = invoiceGroup;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new UpdateInvoiceGroupEvent(invoiceGroup, true, true);
		}	
	}
	
}