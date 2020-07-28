package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	
	import flash.events.Event;

	public class CreateInvoiceGroupEvent extends CairngormEvent
	{
		public static var CREATE_INVOICE_GROUP:String = "createInvoiceGroup";

		public var invoiceGroup:InvoiceGroup;
		
		/**
		 * Constructor.
		 */
		public function CreateInvoiceGroupEvent(invoiceGroup:InvoiceGroup, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( CREATE_INVOICE_GROUP, bubbles, cancelable );
			this.invoiceGroup = invoiceGroup;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new CreateInvoiceGroupEvent(invoiceGroup, true, true);
		}	
	}
	
}