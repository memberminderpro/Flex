package com.infusion.invoice.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetAllInvoiceGroupsForClubEvent extends CairngormEvent
	{
		public static var GET_ALL_INVOICE_GROUPS:String = "getAllInvoiceGroups";

		public var region:int;
		
		/**
		 * Constructor.
		 */
		public function GetAllInvoiceGroupsForClubEvent(region:int, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( GET_ALL_INVOICE_GROUPS, bubbles, cancelable );
			this.region = region;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new GetAllInvoiceGroupsForClubEvent(region, true, true);
		}	
	}
	
}