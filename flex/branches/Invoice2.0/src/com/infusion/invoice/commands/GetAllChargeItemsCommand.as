package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.GetAllChargeItemsEvent;
	import com.infusion.invoice.services.delegates.ChargeItemDelegate;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.*;
	
	public class GetAllChargeItemsCommand extends CommandBase
	{
	  	public function GetAllChargeItemsCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var region:int = (event as GetAllChargeItemsEvent).region;
			
			var delegate:ChargeItemDelegate = new ChargeItemDelegate(this);
			delegate.getAllChargeItems(region);
		}
	
		override public function result( event : Object ):void {	
			var ac:ArrayCollection = event.result as ArrayCollection;
			if(ac == null || ac.length == 0) {
				trace("Error: Received no ChargeItems.  Aborting call.");
				return;
			}
			
			_model.chargeItemsList = ac;
			trace("Received ChargeItems: "+_model.chargeItemsList.length);
			trace(_model.chargeItemsList);
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