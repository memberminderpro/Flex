package com.infusion.invoice.views.components.chargeItemsPanel
{
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;

	public class ChargeControlComponent extends Canvas
	{
		[Bindable] var selectedChargeType:String = "";
		[Bindable] var chargeTypesList:ArrayCollection = new ArrayCollection();
		
		public function ChargeControlComponent()
		{
			super();
		}
		
	}
}