package com.infusion.invoice.model.dtos
{
	[Bindable]
	public class MealCodeVO
	{
		public function MealCodeVO(o:Object) {
			MealCode = o.MealCode;
			MealCodeID = o.MealCodeID;
		}
		public var MealCodeID:int;
		public var MealCode:String;
		
		public function toString():String {
			var s:String = "MealCode={";
			s += "MealCodeID:"+MealCodeID;
			s += "MealCode:"  +MealCode;
			return s;
		}
	}
}