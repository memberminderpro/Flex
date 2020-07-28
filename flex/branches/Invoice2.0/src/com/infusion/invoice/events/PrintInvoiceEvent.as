package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	
	import flash.events.Event;

	public class PrintInvoiceEvent extends CairngormEvent
	{
		public static var PRINT_INVOICE_GROUP:String = "printInvoiceGroup";

		public var invoiceGroup:InvoiceGroup;
		
		public function PrintInvoiceEvent(invoiceGroup:InvoiceGroup, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( PRINT_INVOICE_GROUP, bubbles, cancelable );
			this.invoiceGroup = invoiceGroup;
		}
     	
		override public function clone() : Event
		{
			return new PrintInvoiceEvent(invoiceGroup, true, true);
		}	
	}
}