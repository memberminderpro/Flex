

package com.infusion.accounting.event
{
	import accounts.RegisterDAO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.accounting.models.RegisterLineType;
	
	import flash.events.Event;
	
	public class SelectRegisterLineEvent extends CairngormEvent
	{
		public static var CREATE_NEW_REGISTER_LINE_EVENT:String = "CREATE_NEW_REGISTER_LINE_EVENT";
		
		public var registerLineType:RegisterLineType = null;

		/**
		 * Constructor.
		 */
		public function SelectRegisterLineEvent(registerLineType:RegisterLineType, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( CREATE_NEW_REGISTER_LINE_EVENT, bubbles, cancelable );
			this.registerLineType = registerLineType;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new SelectRegisterLineEvent(registerLineType, true, true);
		}	
	}
	
}