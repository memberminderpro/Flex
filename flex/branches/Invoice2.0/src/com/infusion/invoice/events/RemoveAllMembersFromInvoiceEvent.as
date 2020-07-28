package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	import com.infusion.invoice.model.dtos.Member;
	
	import flash.events.Event;

	public class RemoveAllMembersFromInvoiceEvent extends CairngormEvent
	{
		public static var REMOVE_ALL_MEMBERS_FROM_INVOICE:String = "removeAllMembersFromInvoice";
		
		/**
		 * Constructor.
		 */
		public function RemoveAllMembersFromInvoiceEvent(bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( REMOVE_MEMBER_FROM_INVOICE, bubbles, cancelable );
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new RemoveAllMembersFromInvoiceEvent(true, true);
		}	
	}
	
}