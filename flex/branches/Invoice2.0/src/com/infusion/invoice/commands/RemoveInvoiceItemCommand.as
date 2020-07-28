package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.RemoveInvoiceItemEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	import com.infusion.invoice.services.delegates.InvoiceItemDelegate;
	
	import mx.rpc.events.*;
	
	public class RemoveInvoiceItemCommand extends CommandBase
	{
	  	public function RemoveInvoiceItemCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			//	args.InvoiceGrpID = invoiceGrpID;		// Global selected Invoice
			//	args.ChargeItemID = sel.ItemChargeID;

			var chargeItem:ChargeItem = (event as RemoveInvoiceItemEvent).chargeItem;
			var invoiceGroupID:int = (event as RemoveInvoiceItemEvent).invoiceGroupID;
			
			var delegate:InvoiceItemDelegate = new InvoiceItemDelegate(this);
			delegate.deleteInvoiceItem(invoiceGroupID, chargeItem._chargeItemID);
		}
	
		override public function result( event : Object ):void {	
			var ci:ChargeItem = event.result as ChargeItem;
			if(ci == null) {
				trace("Error: Received no ChargeItems.  Aborting call.");
				return;
			}
			
			_model.chargeItemsList.RemoveItem(ci);
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