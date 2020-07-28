package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.GetAccountsXMLEvent;
	import com.infusion.invoice.services.delegates.GL_AccountDelegate;
	
	import mx.rpc.events.*;
	
	public class GetAccountsXMLCommand extends CommandBase
	{
	  	public function GetAccountsXMLCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var region:int = (event as GetAccountsXMLEvent).region;
			
			var delegate:GL_AccountDelegate = new GL_AccountDelegate(this);
			delegate.getAccounts(region);
		}
	
		override public function result( event : Object ):void {	
			trace("RESULT from "+this);
			var x:XML = event.result as XML;
			if(x == null) {
				trace("Error: Received no Accounts.  Aborting call.");
				return;
			}
			
			_model.accountsList = x;
			trace("Received Accounts: "+_model.accountsList.length);
			trace(_model.accountsList);
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