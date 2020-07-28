package com.infusion.invoice.model.dtos
{
	import mx.collections.ArrayCollection;
	[Bindable]
	[RemoteClass(alias="ChargeMemberType")]
	public class ChargeMemberType
	{
		public var Amount:Number;
		public var ChargeItemID:int;
		public var ChargeMemberTypeID:int;
		public var MemberType:String;
		public var MemberTypeID:int;
	}
}