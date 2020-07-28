package com.infusion.invoice.services.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class InvoiceDelegate
	{
		public function InvoiceDelegate( responder : IResponder )
		{		
			this.service = ServiceLocator.getInstance().getRemoteObject( "invoiceCFC" );
			this.responder = responder;
		}
		
		public function viewInvoice(invoiceID:int) : void
		{			
			var args:Object = {InvoiceGrpID:invoiceID};
			var call : Object = service.View(args); 
			call.addResponder( responder );
		}
		
		//TODO what is difference between view and lookup?
		public function lookupInvoice(invoiceID:int) : void
		{			
			var args:Object = {InvoiceGrpID:invoiceID};
			var call : Object = service.Lookup(args); 
			call.addResponder( responder );
		}
		public function addMember(invoiceID:int, uidToAdd:int) : void
		{			
			var call : Object = service.AddMember(invoiceID, uidToAdd); 
			call.addResponder( responder );
		}
		public function addMembers(invoiceID:int, uidListToAdd:String) : void
		{			
			var call : Object = service.AddMember(invoiceID, uidListToAdd); 
			call.addResponder( responder );
		}
		public function deleteMember(invoiceGroupID:int, delString:String) : void
		{			
			var call : Object = service.DeleteMember(invoiceGroupID, delString); 
			call.addResponder( responder );
		}
		public function deleteMembers(invoiceGroupID:int, delString:String) : void
		{			
			var call : Object = service.DeleteMember(invoiceGroupID, delString); 
			call.addResponder( responder );
		}
	
		private var responder : IResponder;
		private var service : Object;
	}

}