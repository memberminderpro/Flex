package com.infusion.accounting.commands
{
	import accounts.RegisterDAO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.accounting.event.SelectRegisterLineEvent;
	import com.infusion.accounting.models.RegisterLineType;
	
	import mx.controls.Alert;
	import mx.rpc.events.*;
	
	public class CreateNewRegisterLineCommand extends CommandBase
	{
	  	public function CreateNewRegisterLineCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var e:CreateNewRegisterLineEvent = event as CreateNewRegisterLineEvent;
			if(e == null) {
				Alert.show("Error: Received bad or null CreateNewRegisterLineEvent Event.  Aborting call.");
				return;
			}
			
			//TODO decide which type this is (cast to RegisterDAO)
			//Set model
			var reg:RegisterDAO = e.registerItem as RegisterDAO;
			_model.selectedRegisterLine = reg;
			
		}
	
		


	}

}