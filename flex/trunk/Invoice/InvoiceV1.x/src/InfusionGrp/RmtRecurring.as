package InfusionGrp
{
	[Bindable]
	[RemoteClass(alias="ChargeMemberRecurring")]
	public class RmtRecurring
	{
		public var ChargeMemberRecurringID:int;
		public var Amount:Number;
		public var ChargeItemID:int;
		public var UserID:int;
		public var UserName:String;
		public var MemberType:String;
	}
}