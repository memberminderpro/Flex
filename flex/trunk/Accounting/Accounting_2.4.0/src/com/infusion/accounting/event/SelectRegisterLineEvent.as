

package com.infusion.accounting.event
{
	import accounts.RegisterDAO;
	import accounts.RegisterItem;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	public class SelectRegisterLineEvent extends CairngormEvent
	{
		public static var SELECT_REGISTER_LINE_EVENT:String = "SELECT_REGISTER_LINE_EVENT";
		
		public var registerItem:RegisterDAO = null;

		/**
		 * Constructor.
		 */
		public function SelectRegisterLineEvent(registerItem:RegisterDAO, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( SELECT_REGISTER_LINE_EVENT, bubbles, cancelable );
			this.registerItem = registerItem;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new SelectRegisterLineEvent(registerItem, true, true);
		}	
	}
	
}