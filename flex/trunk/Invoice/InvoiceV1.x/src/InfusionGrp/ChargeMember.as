package InfusionGrp
{
	import mx.collections.ArrayCollection;
	[Bindable]
	[RemoteClass(alias="ChargeMemberType")]
	public class ChargeMember
	{
		public var Amount:Number;
		public var ChargeItemID:int;
		public var ChargeMemberTypeID:int;
		public var MemberType:String;
		public var MemberTypeID:int;
	}
}