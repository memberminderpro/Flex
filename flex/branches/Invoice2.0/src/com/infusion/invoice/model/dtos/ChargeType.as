package com.infusion.invoice.model.dtos
{
	//ChargeTypeID, ChargeType, IsActive, TypeID, PositionSort
	public class ChargeType
	{
		// Have to match case from db
		public var ChargeTypeID:int;
		public var ChargeTypeLabel:String;
		public var IsActive:Boolean;
		public var TypeID:int;
		public var PositionSort:int;
	}
}