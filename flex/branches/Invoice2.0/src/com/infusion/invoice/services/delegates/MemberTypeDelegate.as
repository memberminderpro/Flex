package com.infusion.invoice.services.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.IResponder;

	public class MemberTypeDelegate
	{
		public function MemberTypeDelegate( responder : IResponder )
		{		
			this.service = ServiceLocator.getInstance().getRemoteObject( "memberTypeCFC" );
			this.responder = responder;
		}
		
		public function getMemberTypes(clubID:int, s:String="N") : void
		{			
			//TW:cairngorm memberType.Pick2(region,"N");
			var call : Object = service.Pick2(clubID, s); 
			call.addResponder( responder );
		}
	
		private var responder : IResponder;
		private var service : Object;
	}

}