package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.UpdateInvoiceGroupEvent;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	import com.infusion.invoice.services.delegates.InvoiceGroupDelegate;
	
	import mx.rpc.events.*;
	
	public class UpdateInvoiceGroupCommand extends CommandBase
	{
		public function UpdateInvoiceGroupCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var invoiceGroup:InvoiceGroup = (event as UpdateInvoiceGroupEvent).invoiceGroup;
			
			var delegate:InvoiceGroupDelegate = new InvoiceGroupDelegate(this);
			delegate.updateInvoiceGroup(invoiceGroup);
		}
	
		override public function result( event : Object ):void {	
			var invoice:InvoiceGroup = event.result as InvoiceGroup;
			if(invoice == null) {
				trace("Error: Received no Updated Invoice.  Aborting call.");
				return;
			}
			
			//TODO find item_model.chargeItemsList.addItem(ci);
			trace("Received Updated Invoice: "+invoice);
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