package com.infusion.invoice.model.dtos
{
	[Bindable]
	[RemoteClass(alias="ChargeMemberSelected")]
	public class SelectedMember
	{
		public var ChargeMemberSelectedID:int;
		public var IsSelected:Boolean;
		public var ChargeItemID:int;
		public var UserID:int;
		public var UserName:String;
		public var MemberType:String;
		public function toString():String {
			return UserName+" selected?"+IsSelected;
		}
	}
}