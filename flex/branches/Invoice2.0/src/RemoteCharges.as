package
{
	// Class for server update
	[Bindable]
	[RemoteClass(alias="ChargeItem")]
	public class RemoteCharges
	{
		public var ChargeItemID:int;
		public var ChargeItem:String;
		public var ChargeTypeID:int;
		public var ClubID:int;
		public var Amount:String;
		public var GL_AccountID:int;
		public var GL_Account:String;
		public var DateTo:Date;
		public var DateFrom:Date;
		public var DateRangeID:int;
		public var IsActive:String;
		public var TaxPercent:String;
		public var TaxMin:String;
		public var TaxMax:String;
		public var MealCodeID:int;
		public var Created_By:int;
		public var Created_Tmstmp:Date;
	}
}