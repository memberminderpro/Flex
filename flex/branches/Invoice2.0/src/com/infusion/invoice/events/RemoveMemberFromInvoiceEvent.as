package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	import com.infusion.invoice.model.dtos.Member;
	
	import flash.events.Event;

	public class RemoveMemberFromInvoiceEvent extends CairngormEvent
	{
		public static var REMOVE_MEMBER_FROM_INVOICE:String = "removeMemberFromInvoice";

		public var member:Member;
		public var invoiceGroupID:int;
		
		/**
		 * Constructor.
		 */
		public function RemoveMemberFromInvoiceEvent(member:Member, invoiceGroupID:int, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( REMOVE_MEMBER_FROM_INVOICE, member, invoiceGroupID, bubbles, cancelable );
			this.member = member;
			this.invoiceGroupID = invoiceGroupID;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new RemoveMemberFromInvoiceEvent(member, invoiceGroupID, true, true);
		}	
	}
	
}