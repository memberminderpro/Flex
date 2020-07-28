package com.infusion.invoice.services.delegates
{
	import mx.rpc.IResponder;
	import com.adobe.cairngorm.business.ServiceLocator;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.AbstractOperation;

	public class ChargeTypeDelegate
	{
		public function ChargeTypeDelegate( responder : IResponder )
		{		
			this.service = ServiceLocator.getInstance().getRemoteObject( "chargeTypeCFC" );
			this.responder = responder;
		}
		
		public function getAllChargeTypes() : void
		{			
			var call : Object = service.Lookup(); 
			call.addResponder( responder );
		}
	
		private var responder : IResponder;
		private var service : Object;
	}

}