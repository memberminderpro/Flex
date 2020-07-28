package com.infusion.accounting.components.editors
{
	import accounts.RegisterItem;
	
	import mx.containers.HBox;

	public class DepositAccountsSelectorComponent extends HBox
	{
		[Bindable] public var _registerItem:RegisterItem = new RegisterItem();
		
		public function DepositAccountsSelectorComponent()
		{
			super();
		}
		
	}
	
}