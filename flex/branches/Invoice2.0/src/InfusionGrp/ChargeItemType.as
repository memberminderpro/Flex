package InfusionGrp
{
	//ChargeTypeID, ChargeType, IsActive, TypeID, PositionSort
	//a.k.a. dtos.ChargeType
	public class ChargeItemType
	{
		// Have to match case from db
		public var ChargeTypeID:int;
		public var ChargeTypeLabel:String;
		public var IsActive:Boolean;
		public var TypeID:int;
		public var PositionSort:int;
	}
}