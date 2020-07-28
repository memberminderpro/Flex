package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	
	import flash.events.Event;

	public class DeleteInvoiceGroupEvent extends CairngormEvent
	{
		public static var DELETE_INVOICE_GROUP:String = "deleteInvoiceGroup";

		public var invoiceGroup:InvoiceGroup;
		
		/**
		 * Constructor.
		 */
		public function DeleteInvoiceGroupEvent(invoiceGroup:InvoiceGroup, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( DELETE_INVOICE_GROUP, bubbles, cancelable );
			this.invoiceGroup = invoiceGroup;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new DeleteInvoiceGroupEvent(invoiceGroup, true, true);
		}	
	}
	
}