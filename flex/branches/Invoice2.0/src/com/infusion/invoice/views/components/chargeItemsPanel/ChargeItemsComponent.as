package com.infusion.invoice.views.components.chargeItemsPanel
{
	import com.infusion.invoice.model.AppModelLocator;
	import com.infusion.invoice.model.dtos.ChargeItem;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;

	public class ChargeItemsComponent extends HBox
	{
		[Bindable] public var _model:AppModelLocator;
		[Bindable] public var boundChargeItems:ArrayCollection = new ArrayCollection();
		[Bindable] public var boundChargeTypes:ArrayCollection = new ArrayCollection();
		[Bindable] public var boundMealCodes:ArrayCollection = new ArrayCollection();
		[Bindable] public var boundDatePeriods:ArrayCollection = new ArrayCollection();
		[Bindable] public var selectedChargeItem:ChargeItem = null;
		
		public function ChargeItemsComponent()
		{
			super();
		}
				
	}
}