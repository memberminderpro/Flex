package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	
	import flash.events.Event;

	public class ViewInvoiceEvent extends CairngormEvent
	{
		public static var VIEW_INVOICE:String = "viewInvoice";

		public var invoiceID:int;
		
		/**
		 * Constructor.
		 */
		public function ViewInvoiceEvent(invoiceID:int, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( VIEW_INVOICE, bubbles, cancelable );
			this.invoiceID = invoiceID;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new ViewInvoiceEvent(invoiceID, true, true);
		}	
	}
	
}