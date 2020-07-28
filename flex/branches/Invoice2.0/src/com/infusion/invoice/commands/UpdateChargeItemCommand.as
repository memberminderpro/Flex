package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.UpdateChargeItemEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	import com.infusion.invoice.services.delegates.ChargeItemDelegate;
	
	import mx.rpc.events.*;
	
	public class UpdateChargeItemCommand extends CommandBase
	{
		public function UpdateChargeItemCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var chargeItem:ChargeItem = (event as UpdateChargeItemEvent).chargeItem;
			
			var delegate:ChargeItemDelegate = new ChargeItemDelegate(this);
			delegate.UpdateChargeItem(chargeItem);
		}
	
		override public function result( event : Object ):void {	
			var ci:ChargeItem = event.result as ChargeItem;
			if(ci == null) {
				trace("Error: Received no ChargeItems.  Aborting call.");
				return;
			}
			
			//TODO find item_model.chargeItemsList.addItem(ci);
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