package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	
	import flash.events.Event;

	public class PrintPreviewInvoiceEvent extends CairngormEvent
	{
		public static var PRINT_PREVIEW_INVOICE_GROUP:String = "printPreviewInvoiceGroup";

		public var invoiceGroup:InvoiceGroup;
		
		public function PrintPreviewInvoiceEvent(invoiceGroup:InvoiceGroup, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( PRINT_PREVIEW_INVOICE_GROUP, bubbles, cancelable );
			this.invoiceGroup = invoiceGroup;
		}
     	
		override public function clone() : Event
		{
			return new PrintPreviewInvoiceEvent(invoiceGroup, true, true);
		}	
	}
}