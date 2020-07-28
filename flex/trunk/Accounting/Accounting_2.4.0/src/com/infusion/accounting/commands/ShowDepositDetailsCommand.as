package com.infusion.accounting.commands
{
	import accounts.RegisterDAO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.accounting.event.ShowDepositDetailsEvent;
	import com.infusion.accounting.models.RegisterLineType;
	
	import mx.controls.Alert;
	import mx.rpc.events.*;
	
	public class ShowDepositDetailsCommand extends CommandBase
	{
	  	public function ShowDepositDetailsCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var e:ShowDepositDetailsEvent = event as ShowDepositDetailsEvent;
			if(e == null) {
				trace("Error: Received bad or null ShowDepositDetails Event.  Aborting call.");
				return;
			}
			
			//TODO decide which type this is (cast to RegisterDAO)
			//Set model
			var reg:RegisterDAO = e.registerItem as RegisterDAO;
			_model.selectedRegisterLine = reg;
			try {
				if(reg.bitIsDeposit) {
					_model.selectedRegItemType = RegisterLineType.DEPOSIT;
				} else if(reg.bitIsCheck) {
					_model.selectedRegItemType = RegisterLineType.CHECK;
				} else if(reg.bitIsSplit) {
					_model.selectedRegItemType = RegisterLineType.SPLIT;
				} else {
					trace("Cannot determine Register type from: "+reg.toString());
				}
			} catch(error:Error) {
				trace("Cannot set selectedRegItemType due to: "+error.message);
			}
			
		}
	
		


	}

}