package com.infusion.invoice.commands
{
	import com.infusion.invoice.events.LookupChargeItemsEvent;
	import com.infusion.invoice.services.delegates.InvoiceItemDelegate;
	
	import mx.rpc.events.*;
	
	public class LookupChargeItemsCommand extends CommandBase
	{
	  	public function LookupChargeItemsCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var invoiceID:int = (event as LookupChargeItemsEvent).invoiceGroupID;
			
			var delegate:InvoiceItemDelegate = new InvoiceItemDelegate(this);
			delegate.lookupChargeItems(invoiceID);
		}
	
		override public function result( event : Object ):void {	
			//TODO
			var invoice:Invoice = event.result as Invoice;
			if(invoice == null) {
				trace("Error: Received no Invoice.  Aborting call.");
				return;
			}
			
			_model.chargeItemsList.addItem(ci);
			trace("Received ChargeItems: "+ci);
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