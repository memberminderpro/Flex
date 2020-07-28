package com.infusion.attendanceoffline.services.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.IResponder;
	import mx.rpc.AsyncToken;

	public class ClubMeetingDelegate
	{
		private var responder : IResponder;
		private var service : Object;
		
		public function ClubMeetingDelegate( responder : IResponder )
		{		
			this.service = ServiceLocator.getInstance().getRemoteObject( "clubMeetingRO" );
			this.responder = responder;
		}
		
		/* example
		public function getMessage(name:String) : void
		{			
			var call : Object = service.sayHello(name);
			call.addResponder( responder );
		}
		*/
		
		public function login(name:String, password:String):void {
			var args:Object = {'LoginName':name, 'Password':password};
			
			//args.LoginName = config.userNm;
			//args.Password = config.userPw;
			//log.debug("Connecting to server: "+clubMeeting.destination+", "+clubMeeting.endpoint);
			//log.debug("Login information: "+args.LoginName+", "+args.Password);
			var call:AsyncToken = this.service.Login(args);
			call.addResponder(this.responder);
		}
		
		/**
		 * a.k.a Lookup: gets a list of all open meetings for clubID from server
		 */
		public function getAllMeetingsForClub(clubID:int):void {
			var call:AsyncToken = this.service.Lookup(clubID);
			call.addResponder(this.responder);
		}
		
		/**
		 * a.k.a Lookup: gets a list of all open meetings for clubID from server
		 */
		public function getMealCodesForClub(clubID:int):void {
			var call:AsyncToken = this.service.MealCode(clubID);
			call.addResponder(this.responder);
		}

	}

}