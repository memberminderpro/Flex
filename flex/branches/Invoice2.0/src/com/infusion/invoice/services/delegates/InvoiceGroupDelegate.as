package com.infusion.invoice.services.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	
	import mx.rpc.IResponder;

	public class InvoiceGroupDelegate
	{
		public function InvoiceGroupDelegate( responder : IResponder )
		{		
			this.service = ServiceLocator.getInstance().getRemoteObject( "remoteCFC" );
			this.responder = responder;
		}
		
		public function lookup(region:int) : void
		{			
			var args:Object = {District:region};
			var call : Object = service.Lookup(args); 
			call.addResponder( responder );
		}
		
		public function createInvoiceGroup(invoiceGroup:InvoiceGroup) : void
		{			
			var call : Object = service.Create(invoiceGroup, "N");
			call.addResponder( responder );
		}
	
		public function deleteInvoiceGroup(invoiceGroup:InvoiceGroup) : void
		{			
			var call : Object = service.Delete(invoiceGroup, "N");
			call.addResponder( responder );
		}
		
		public function updateInvoiceGroup(invoiceGroup:InvoiceGroup) : void
		{			
			var call : Object = service.Update(invoiceGroup, "N");
			call.addResponder( responder );
		}
		private var responder : IResponder;
		private var service : Object;
	}

}