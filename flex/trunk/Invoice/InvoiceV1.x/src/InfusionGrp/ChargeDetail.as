package InfusionGrp
{
	
	[Bindable]
	[RemoteClass(alias="ChargeItemDetail")]
		public class ChargeDetail
		{
			public var ChargeItemDetailID:int;
			public var ChargeItemDetail:String;
			public var ChargeItemID:int;
			public var Amount:String;
			public var DateRangeID:int;
			public var DateFrom:Date;
			public var DateTo:Date;
			public var Created_By:int;
			public var Created_Tmstmp:Date;
		}
}