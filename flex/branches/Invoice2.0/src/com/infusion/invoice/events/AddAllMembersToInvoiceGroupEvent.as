package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class AddAllMembersToInvoiceGroupEvent extends CairngormEvent
	{
		public static var ADD_ALL_MEMBERS_TO_INVOICE_GROUP:String = "addAllMembersToInvoiceGroup";
		
		var selectedMembers:ArrayCollection = new ArrayCollection();
		/**
		 * Constructor.
		 */
		public function AddAllMembersToInvoiceGroupEvent(selectedMembers:ArrayCollection, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( ADD_ALL_MEMBERS_TO_INVOICE_GROUP, bubbles, cancelable );
			this.selectedMembers = selectedMembers;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new AddAllMembersToInvoiceGroupEvent(selectedMembers, true, true);
		}	
	}
	
}