package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.GetAllInvoiceGroupsForClubEvent;
	import com.infusion.invoice.services.delegates.InvoiceGroupDelegate;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.*;
	
	public class GetAllInvoiceGroupsForClubCommand extends CommandBase
	{
	  	public function GetAllInvoiceGroupsForClubCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var region:int = (event as GetAllInvoiceGroupsForClubEvent).region;
			
			var delegate:InvoiceGroupDelegate = new InvoiceGroupDelegate(this);
			delegate.lookup(region);
		}
	
		override public function result( event : Object ):void {	
			trace("RESULT from "+this);
			var ac:ArrayCollection = event.result as ArrayCollection;
			if(ac == null || ac.length == 0) {
				trace("Error: Received no InvoiceGroups.  Aborting call.");
				return;
			}
			
			_model.invoiceGroupsList = ac;
			trace("Received InvoiceGroups: "+_model.invoiceGroupsList.length);
			trace(_model.invoiceGroupsList);
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