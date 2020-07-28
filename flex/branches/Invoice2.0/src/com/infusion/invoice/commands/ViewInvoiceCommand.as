package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.ViewInvoiceEvent;
	import com.infusion.invoice.services.delegates.InvoiceDelegate;
	
	import mx.rpc.events.*;
	
	public class ViewInvoiceCommand extends CommandBase
	{
	  	public function ViewInvoiceCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var invoiceID:int = (event as ViewInvoiceEvent).invoiceID;
			
			var delegate:InvoiceDelegate = new InvoiceDelegate(this);
			delegate.viewInvoice(invoiceID);
		}
	
		override public function result( event : Object ):void {	
			var invoice:Invoice = event.result as Invoice;
			if(invoice == null) {
				trace("Error: Received no Invoice.  Aborting call.");
				return;
			}
			
			//TODO handle _model.chargeItemsList.addItem(ci);
			trace("Received Invoices: "+invoice);
			/* Write them out
			for(var i:int=0; i < _model.chargeItemsList.length; i++) { 
				var o:Object = (_model.chargeItemsList.getItemAt(i));
				//var m:Meeting = new Meeting(_model.invoiceGroupsList.getItemAt(i));
				//trace((m));
			}
			*/		
		}

	}

}