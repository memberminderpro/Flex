package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.Member;
	import com.infusion.invoice.events.AddMemberToInvoiceGroupEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	import com.infusion.invoice.services.delegates.InvoiceDelegate;
	
	import mx.rpc.events.*;
	
	public class AddMemberToInvoiceGroupCommand extends CommandBase
	{
	  	public function AddMemberToInvoiceGroupCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			//	args.InvoiceGrpID = invoiceGrpID;		// Global selected Invoice
			//	args.ChargeItemID = sel.ItemChargeID;

			var member:Member = (event as AddMemberToInvoiceGroupEvent).member;
			var invoiceGroupID:int = (event as AddMemberToInvoiceGroupEvent).invoiceGroupID;
			
			var delegate:InvoiceDelegate = new InvoiceDelegate(this);
			delegate.addMember(invoiceGroupID, member.userID);
		}
	
		override public function result( event : Object ):void {	
			trace("RESULT from "+this);
			var ci:ChargeItem = event.result as ChargeItem;
			if(ci == null) {
				trace("Error: Received no ChargeItems.  Aborting call.");
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