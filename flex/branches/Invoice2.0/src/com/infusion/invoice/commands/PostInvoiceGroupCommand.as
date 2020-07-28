package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.PostInvoiceGroupEvent;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	
	import mx.rpc.events.*;
	
	public class PostInvoiceGroupCommand extends CommandBase
	{
		private var invoiceGroup:InvoiceGroup;
	  	public function PostInvoiceGroupCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			invoiceGroup = (event as PostInvoiceGroupEvent).invoiceGroup;

			var url:String = _model.endPoint;
			var idx:int;
			var request:URLRequest;
			var urlVars:URLVariables = new URLVariables();
			idx = url.lastIndexOf("/");
			url = url.slice(0, idx+1);
			url += _model.destination + "/ClubDues/postInvoice.cfm";
			request = new URLRequest(url);
			request.method = "GET";
			urlVars.InvoiceGrpID=invoiceGroup.InvoiceGrpID;
			request.data = urlVars;
			navigateToURL(request,'_blank');
			
			//affect the GUI
			//TODO decide to do another View of this InvoiceGroup to pick up PostedDate
			invoiceGroup.IsPosted = "Y";
			//TODO setViewState(currentState); //need to make read-only since we posted
		}
	
		override public function result( event : Object ):void {
			trace("RESULT from "+this);	
		}

	}

}