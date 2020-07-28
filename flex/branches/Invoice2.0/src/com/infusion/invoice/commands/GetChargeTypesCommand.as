package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.services.delegates.ChargeTypeDelegate;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.*;
	
	public class GetChargeTypesCommand extends CommandBase
	{
	  	public function GetChargeTypesCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {		
			var delegate:ChargeTypeDelegate = new ChargeTypeDelegate(this);
			delegate.getAllChargeTypes();
		}
	
		override public function result( event : Object ):void {
			trace("RESULT from "+this);	
			var ac:ArrayCollection = event.result as ArrayCollection;
			if(ac == null || ac.length == 0) {
				trace("Error: Received no ChargeTypes.  Aborting call.");
				return;
			}
			
			_model.chargeTypesList = ac;
			trace("Received ChargeTypes: "+_model.chargeTypesList.length);
			trace(_model.chargeTypesList);
			/* Write them out
			for(var i:int=0; i < _model.invoiceGroupsList.length; i++) { 
				var o:Object = (_model.invoiceGroupsList.getItemAt(i));
				var m:Meeting = new Meeting(_model.invoiceGroupsList.getItemAt(i));
				trace((m));
			}
			*/		
		}

	}

}