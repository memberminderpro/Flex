package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.dtos.ChargeItem;
	
	import flash.events.Event;

	public class CreateChargeItemEvent extends CairngormEvent
	{
		public static var CREATE_CHARGE_ITEM:String = "createChargeItem";

		public var chargeItem:ChargeItem;
		
		/**
		 * Constructor.
		 */
		public function CreateChargeItemEvent(chargeItem:ChargeItem, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( CREATE_CHARGE_ITEM, bubbles, cancelable );
			this.chargeItem = chargeItem;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new CreateChargeItemEvent(chargeItem, true, true);
		}	
	}
	
}