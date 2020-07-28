

package com.infusion.accounting.event
{
	import accounts.RegisterDAO;
	import accounts.RegisterItem;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	public class ShowDepositDetailsEvent extends CairngormEvent
	{
		public static var SHOW_DEPOSIT_DETAILS_EVENT:String = "SHOW_DEPOSIT_DETAILS_EVENT";
		
		public var registerItem:RegisterDAO = null;

		/**
		 * Constructor.
		 */
		public function ShowDepositDetailsEvent(registerItem:RegisterDAO, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( SHOW_DEPOSIT_DETAILS_EVENT, bubbles, cancelable );
			this.registerItem = registerItem;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new ShowDepositDetailsEvent(registerItem, true, true);
		}	
	}
	
}