package com.infusion.invoice.services.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class InvoiceItemDelegate
	{
		public function InvoiceItemDelegate( responder : IResponder )
		{		
			this.service = ServiceLocator.getInstance().getRemoteObject( "invoiceItemCFC" );
			this.responder = responder;
		}
		
		public function lookupChargeItems(invoiceID:int) : void
		{			
			var args:Object = {InvoiceGrpID:invoiceID};
			var call : Object = service.LookupChargeItems(args); 
			call.addResponder( responder );
		}
		
		public function addInvoiceItem(invoiceGroupID:int, chargeItemID:int) : void
		{			
			var args:Object = {InvoiceGrpID:invoiceGroupID, ChargeItemID:chargeItemID };
			var call : Object = service.AddInvoiceItem(args); 
			call.addResponder( responder );
		}
		public function deleteInvoiceItem(invoiceGroupID:int, chargeItemID:int) : void
		{		
			var args:Object = {InvoiceGrpID:invoiceGroupID, ChargeItemID:chargeItemID };	
			var call : Object = service.DeleteInvoiceItem(args); 
			call.addResponder( responder );
		}
	
		private var responder : IResponder;
		private var service : Object;
	}

}