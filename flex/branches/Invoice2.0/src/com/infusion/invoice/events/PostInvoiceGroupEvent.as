package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	
	import flash.events.Event;

	public class PostInvoiceGroupEvent extends CairngormEvent
	{
		public static var POST_INVOICE_GROUP:String = "postInvoiceGroup";

		public var invoiceGroup:InvoiceGroup;
		
		public function PostInvoiceGroupEvent(invoiceGroup:InvoiceGroup, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( POST_INVOICE_GROUP, bubbles, cancelable );
			this.invoiceGroup = invoiceGroup;
		}
     	
		override public function clone() : Event
		{
			return new PostInvoiceGroupEvent(invoiceGroup, true, true);
		}	
	}
}