package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.DeleteInvoiceGroupEvent;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	import com.infusion.invoice.services.delegates.InvoiceGroupDelegate;
	
	import mx.rpc.events.*;
	
	public class DeleteInvoiceGroupCommand extends CommandBase
	{
		private var invoiceGroup:InvoiceGroup;
	  	public function DeleteInvoiceGroupCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			invoiceGroup = (event as DeleteInvoiceGroupEvent).invoiceGroup;
			
			var delegate:InvoiceGroupDelegate = new InvoiceGroupDelegate(this);
			delegate.deleteInvoiceGroup(invoiceGroup);
		}
	
		override public function result( event : Object ):void {
			trace("RESULT from "+this);	
			var id:int = event.result as int;
			if(id <= 0) {
				trace("Error: Received no Deleted Invoice Group ID.  Aborting call.");
				return;
			}
			
			//Delete from the list
			invoiceGroup.InvoiceGrpID = id;
			//_model.invoiceGroupsList.addItem(invoiceGroup);
			trace("Deleted InvoiceGroup: "+invoiceGroup);
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