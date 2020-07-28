package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	
	import flash.events.Event;

	public class DeleteChargeItemEvent extends CairngormEvent
	{
		public static var DELETE_CHARGE_ITEM:String = "deleteChargeItem";

		public var chargeItem:ChargeItem;
		
		/**
		 * Constructor.
		 */
		public function DeleteChargeItemEvent(chargeItem:ChargeItem, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( DELETE_CHARGE_ITEM, bubbles, cancelable );
			this.chargeItem = chargeItem;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new DeleteChargeItemEvent(chargeItem, true, true);
		}	
	}
	
}