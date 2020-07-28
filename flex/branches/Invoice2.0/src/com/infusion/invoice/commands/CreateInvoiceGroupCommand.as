package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.CreateInvoiceGroupEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	import com.infusion.invoice.services.delegates.InvoiceGroupDelegate;
	
	import mx.rpc.events.*;
	
	public class CreateInvoiceGroupCommand extends CommandBase
	{
		private var invoiceGroup:InvoiceGroup;
	  	public function CreateInvoiceGroupCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			invoiceGroup = (event as CreateInvoiceGroupEvent).invoiceGroup;
			
			var delegate:InvoiceGroupDelegate = new InvoiceGroupDelegate(this);
			delegate.createInvoiceGroup(invoiceGroup);
		}
	
		override public function result( event : Object ):void {
			trace("RESULT from "+this);	
			var id:int = event.result as int;
			if(id <= 0) {
				trace("Error: Received no New Invoice Group ID.  Aborting call.");
				return;
			}
			
			//Adding ID to new invoice and then add it to the list
			invoiceGroup.InvoiceGrpID = id;
			_model.invoiceGroupsList.addItem(invoiceGroup);
			trace("Received New InvoiceGroup: "+invoiceGroup);
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