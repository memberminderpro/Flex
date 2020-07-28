package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.AddInvoiceItemEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	import com.infusion.invoice.services.delegates.InvoiceItemDelegate;
	
	import mx.rpc.events.*;
	
	public class AddInvoiceItemCommand extends CommandBase
	{
	  	public function AddInvoiceItemCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			//	args.InvoiceGrpID = invoiceGrpID;		// Global selected Invoice
			//	args.ChargeItemID = sel.ItemChargeID;

			var chargeItem:ChargeItem = (event as AddInvoiceItemEvent).chargeItem;
			var invoiceGroupID:int = (event as AddInvoiceItemEvent).invoiceGroupID;
			
			var delegate:InvoiceItemDelegate = new InvoiceItemDelegate(this);
			delegate.addInvoiceItem(invoiceGroupID, chargeItem._chargeItemID);
		}
	
		override public function result( event : Object ):void {	
			var ci:ChargeItem = event.result as ChargeItem;
			if(ci == null) {
				trace("Error: Received no InvoiceItems.  Aborting call.");
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