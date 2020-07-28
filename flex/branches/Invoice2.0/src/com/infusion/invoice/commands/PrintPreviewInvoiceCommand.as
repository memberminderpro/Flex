package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	
	import mx.rpc.events.*;
	
	public class PrintPreviewInvoiceCommand extends CommandBase
	{
		private var invoiceGroup:InvoiceGroup;
	  	public function PrintPreviewInvoiceCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			invoiceGroup = (event as PrintPreviewInvoiceEvent).invoiceGroup;
			var url:String = _model.endPoint;
			var idx:int;
			var request:URLRequest;
			var urlVars:URLVariables = new URLVariables();
			idx = url.lastIndexOf("/");
			url = url.slice(0, idx+1);
			url += dsn + "/ClubDues/PreviewInvoice.cfm";
			request = new URLRequest(url);
			request.method = "GET";
			urlVars.InvoiceGrpID = _model.selectedInvoiceGroup.InvoiceGrpID;
			request.data = urlVars;
			navigateToURL(request,'_blank');
		}
	
		override public function result( event : Object ):void {
			trace("RESULT from "+this);	
			
		}

	}

}