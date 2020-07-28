package com.infusion.attendanceoffline.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class LoginEvent extends CairngormEvent
	{
		public static var LOGIN:String = "login";

		public var username:String = "";
		public var password:String = "";
		
		/**
		 * Constructor.
		 */
		public function LoginEvent(username:String, password:String, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(LOGIN,bubbles, cancelable);
			this.username = username;
			this.password = password;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new LoginEvent(username, password, true, true);
		}	
	}
	
}