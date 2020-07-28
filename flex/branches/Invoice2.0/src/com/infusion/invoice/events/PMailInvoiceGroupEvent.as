package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	
	import flash.events.Event;

	public class PMailInvoiceGroupEvent extends CairngormEvent
	{
		public static var PMAIL_INVOICE_GROUP:String = "pmailInvoiceGroup";

		public var invoiceGroup:InvoiceGroup;
		
		public function PMailInvoiceGroupEvent(invoiceGroup:InvoiceGroup, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( PMAIL_INVOICE_GROUP, bubbles, cancelable );
			this.invoiceGroup = invoiceGroup;
		}
     	
		override public function clone() : Event
		{
			return new PMailInvoiceGroupEvent(invoiceGroup, true, true);
		}	
	}
}