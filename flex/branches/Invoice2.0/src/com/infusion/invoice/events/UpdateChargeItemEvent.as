package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	
	import flash.events.Event;

	public class UpdateChargeItemEvent extends CairngormEvent
	{
		public static var UPDATE_CHARGE_ITEM:String = "updateChargeItem";

		public var chargeItem:ChargeItem;
		
		/**
		 * Constructor.
		 */
		public function UpdateChargeItemEvent(chargeItem:ChargeItem, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( UPDATE_CHARGE_ITEM, bubbles, cancelable );
			this.chargeItem = chargeItem;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new UpdateChargeItemEvent(chargeItem, true, true);
		}	
	}
	
}