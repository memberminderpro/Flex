package com.infusion.accounting.components
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.containers.VBox;
	import mx.controls.Alert;

	public class RegisterComponentBase extends VBox
	{
		[Bindable] public var dataRegister:ArrayCollection = new ArrayCollection();
		[Bindable] public var dueDateVisible:Boolean = false;
		[Bindable] public var creditHeaderLabel:String = "Deposit";
		[Bindable] public var debitHeaderLabel:String  = "Amount";
		
		public function RegisterComponentBase()
		{
			super();
		}
		
		protected function localClickItem(e:Event):void {
			//TODO send cairngorm event 
			//clkRegister
			trace("Local Click TODO");
			
		}
		
		private function gridTip(item:Object):String
		{
			var s:String = "";
			if (item != null)
			{
				if (item.fEdit)
					s = "Double click to edit this item (GL_AccountID=" + item.GL_AccountID + ")";
				return s;
			}
			else	  
				return s;
		}
		
	}
}