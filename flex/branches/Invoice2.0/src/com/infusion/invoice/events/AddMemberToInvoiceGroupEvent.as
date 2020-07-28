package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.Member;
	
	import flash.events.Event;

	public class AddMemberToInvoiceGroupEvent extends CairngormEvent
	{
		public static var ADD_MEMBER_TO_INVOICE_GROUP:String = "addMemberToInvoiceGroup";

		public var member:Member;
		public var invoiceGroupID:int;
		
		/**
		 * Constructor.
		 */
		public function AddMemberToInvoiceGroupEvent(member:Member, invoiceGroupID:int, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( ADD_MEMBER_TO_INVOICE_GROUP, member, invoiceGroupID, bubbles, cancelable );
			this.member = member;
			this.invoiceGroupID = invoiceGroupID;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new AddMemberToInvoiceGroupEvent(member, invoiceGroupID, true, true);
		}	
	}
	
}