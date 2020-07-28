package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.PMailInvoiceGroupEvent;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	import com.infusion.invoice.services.delegates.InvoiceGroupDelegate;
	
	import mx.rpc.events.*;
	
	public class PMailInvoiceGroupCommand extends CommandBase
	{
		private var invoiceGroup:InvoiceGroup;
	  	public function PMailInvoiceGroupCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			invoiceGroup = (event as PMailInvoiceGroupEvent).invoiceGroup;
			
			var url:String = _endPoint;
			var idx:int;
			var request:URLRequest;
			var urlVars:URLVariables = new URLVariables();
			idx = url.lastIndexOf("/");
			url = url.slice(0, idx+1);
			url += dsn + "/ClubDues/PmailInvoice.cfm";
			request = new URLRequest(url);
			request.method = "GET";
			urlVars.InvoiceGrpID = invoiceGroup.InvoiceGrpID;
			request.data = urlVars;
			navigateToURL(request,'_blank');
		}
	
		override public function result( event : Object ):void {
			trace("RESULT from "+this);	
			
		}

	}

}