package com.infusion.invoice.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetAccountsXMLEvent extends CairngormEvent
	{
		public static var GET_ACCOUNTS_XML:String = "getAccountsXML";

		public var region:int;
		
		/**
		 * Constructor.
		 */
		public function GetAccountsXMLEvent(region:int, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( GET_ACCOUNTS_XML, bubbles, cancelable );
			this.region = region;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new GetAccountsXMLEvent(region, true, true);
		}	
	}
	
}