package InfusionGrp
{
	import mx.formatters.CurrencyFormatter;
	
	public class SelectedMember
	{
		private var _rmt:RmtSelectedMember;
		private var _bDirty:Boolean;
		public function SelectedMember(obj:Object)
		{
			_rmt = new RmtSelectedMember;
			_bDirty = false;
			if(obj != null)
			{
				_rmt.IsSelected = obj.IsSelected;
				_rmt.ChargeItemID = obj.ChargeItemID;
				_rmt.ChargeMemberSelectedID = obj.ChargeMemberSelectedID;
				_rmt.UserID = obj.UserID;
				_rmt.UserName = obj.UserName;
				_rmt.MemberType = obj.MemberType;
			}
			
		}
		/*
			Setters & Getters
		*/
		public function set IsSelected(b:Boolean):void
		{
			_rmt.IsSelected = b;
			_bDirty = true;
		}
		public function get IsSelected():Boolean
		{
			return _rmt.IsSelected;
		}
		
		public function set UserName(s:String):void
		{
			_rmt.UserName = s;
		}
		public function get UserName():String
		{
			return _rmt.UserName;
		}
		public function set UserID(i:int):void
		{
			_rmt.UserID = i;
		}
		public function get UserID():int
		{
			return _rmt.UserID;
		}
		public function set ChargeItemID(i:int):void
		{
			_rmt.ChargeItemID = i;
			_bDirty = true;
		}
		public function get ChargeItemID():int
		{
			return _rmt.ChargeItemID;
		}
		public function set ChargeMemberSelectedID(i:int):void
		{
			_rmt.ChargeMemberSelectedID = i;
		}
		public function get ChargeMemberSelectedID():int
		{
			return _rmt.ChargeMemberSelectedID;
		}
		
		public function set MemberType(s:String):void
		{
			_rmt.MemberType = s;
		}
		public function get MemberType():String
		{
			return _rmt.MemberType;
		}
		public function get MemberSelected():RmtSelectedMember
		{
			return _rmt;
		}
		public function get DirtyFlag():Boolean
		{
			return _bDirty;
		}
	}
}