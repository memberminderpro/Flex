package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	import com.infusion.invoice.model.dtos.Member;
	import com.infusion.invoice.services.delegates.InvoiceDelegate;
	
	import mx.rpc.events.*;
	
	public class AddAllMembersToInvoiceGroupCommand extends CommandBase
	{
	  	public function AddAllMembersToInvoiceGroupCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			//	args.InvoiceGrpID = invoiceGrpID;		// Global selected Invoice
			//	args.ChargeItemID = sel.ItemChargeID;
			var uid:String ="";

			//Loop over and only send ones not already selected to save space
			for(var i:int=0; i<_model.membersList.length; i++) {
				var member:Member =  _model.membersList.getItemAt(i) as Member;
				if(!member.selected ) {  // Not already on the list
					member.selected = true; //Should set in model before sending
					uid += member.userID;
					if(i+1 < _model.membersList.length) uid += ",";
				}
			}
			
			var delegate:InvoiceDelegate = new InvoiceDelegate(this);
			delegate.addMembers(_model.selectedInvoiceGroup.InvoiceGrpID, uid);
		}
	
		override public function result( event : Object ):void {
			//TODO correct this	
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