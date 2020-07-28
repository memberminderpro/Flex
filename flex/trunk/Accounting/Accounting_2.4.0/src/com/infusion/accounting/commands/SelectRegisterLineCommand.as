package com.infusion.accounting.commands
{
	import accounts.RegisterDAO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.accounting.event.SelectRegisterLineEvent;
	import com.infusion.accounting.models.RegisterLineType;
	
	import mx.controls.Alert;
	import mx.rpc.events.*;
	
	public class SelectRegisterLineCommand extends CommandBase
	{
	  	public function SelectRegisterLineCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var e:SelectRegisterLineEvent = event as SelectRegisterLineEvent;
			if(e == null) {
				Alert.show("Error: Received bad or null SelectRegisterLineEvent Event.  Aborting call.");
				return;
			}
			
			//TODO decide which type this is (cast to RegisterDAO)
			//Set model
			
			var reg:RegisterDAO = e.registerItem as RegisterDAO;
			_model.selectedRegisterLine = reg;
			//Alert.show("RegLine selected: "+reg);
			
			//TW: 2.5.3 Check to see if we should enable lock
			_model.selectedRegisterLineIsLocked = _model.selectedRegisterLine.fBitLocked;
			
			//TW: 2.5.9  Should be able to delete?
			_model.selectedRegisterLineDeletable = reg.fEdit;
		}
	
		


	}

}