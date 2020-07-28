package com.infusion.attendanceoffline.services.server
{
	import mx.rpc.IResponder;
	import com.adobe.cairngorm.business.ServiceLocator;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.AbstractOperation;

	public class ClubAttendanceDelegate
	{
		public function ClubAttendanceDelegate( responder : IResponder )
		{		
			this.service = ServiceLocator.getInstance().getRemoteObject( "clubAttendanceRO" );
			this.responder = responder;
		}
		
		public function getMessage(name:String) : void
		{			
			var call : Object = service.sayHello(name);
			call.addResponder( responder );
		}
	
		private var responder : IResponder;
		private var service : Object;
	}

}