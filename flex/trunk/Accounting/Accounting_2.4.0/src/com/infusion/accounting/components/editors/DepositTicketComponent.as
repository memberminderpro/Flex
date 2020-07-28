package com.infusion.accounting.components.editors
{
	import accounts.RegisterItem;
	
	import com.infusion.accounting.models.AppModelLocator;
	
	import mx.collections.XMLListCollection;
	import mx.containers.HBox;

	public class DepositTicketComponent extends HBox
	{
		public var _entityID:int = 0; //editorData
		[Bindable] public var _model:AppModelLocator = AppModelLocator.getInstance();
		[Bindable] public var membersList:XMLListCollection = new XMLListCollection();
		
		override protected function createChildren():void {
			super.createChildren();
			
			var mList:XMLList = _model.membersList.copy();
			var dummy:XML = <member name="-- Select a Member --" value="0"/>;
			//Now add the first selection 
			membersList = new XMLListCollection(mList);
			membersList.addItemAt(dummy, 0);
		}
		
		[Bindable] public var _registerItem:RegisterItem = new RegisterItem();
		
		public function DepositTicketComponent()
		{
			super();
		}
		
	}
	
}