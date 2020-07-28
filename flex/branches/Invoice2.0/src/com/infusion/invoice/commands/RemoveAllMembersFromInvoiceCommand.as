package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.RemoveMemberFromInvoiceEvent;
	import com.infusion.invoice.model.dtos.Member;
	import com.infusion.invoice.services.delegates.InvoiceDelegate;
	
	import mx.rpc.events.*;
	
	public class RemoveAllMembersFromInvoiceCommand extends CommandBase
	{
	  	public function RemoveAllMembersFromInvoiceCommand()
		{	 
		}
	
		//TODO figure out why delete wants list of members but add only wanted UIDs
		override public function execute( event:CairngormEvent ):void {
			var i:int = 0, len:int = _model.membersList.length;
			var uidDel:Array = new Array();
			//Loop over and only send ones not already selected to save space
			for (i=0; i<len; i++) {
				if(arMemberList.getItemAt(i).IsSelected) {
					uidDel.push(arMemberList.getItemAt(i));
				}
			}
			var delegate:InvoiceDelegate = new InvoiceDelegate(this);
			delegate.deleteMembers(_model.selectedInvoiceGroup.InvoiceGrpID, member.userID);
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