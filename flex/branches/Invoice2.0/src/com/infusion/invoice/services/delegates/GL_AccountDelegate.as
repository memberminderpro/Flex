package com.infusion.invoice.services.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.IResponder;

	public class GL_AccountDelegate
	{
		private var responder : IResponder;
		private var service : Object;
		
		public function GL_AccountDelegate( responder : IResponder )
		{		
			this.service = ServiceLocator.getInstance().getRemoteObject( "accountCFC" );
			this.responder = responder;
		}
		
		public function getAccounts(clubID:int) : void
		{	
			//var args:Object = {ClubID:objClub, Override:"N", ExclDues:"Y"};
			var args:Object = {ClubID:clubID, Override:"N", ExclDues:"Y"};
			var call : Object = service.PickXML(args); 
			call.addResponder( responder );
		}
		
		public function getClubMembers(clubID:int, isOverride:Boolean, terminationDate:Date) : void
		{			
			var overrideString:String = (isOverride)?"Y":"N";
			var args:Object = {ClubID:clubID,Override:overrideString, TermDate:terminationDate};
			var call : Object = service.getClubMembers(args); 
			call.addResponder( responder );
		}
	}
}	