package InfusionGrp
{
	import mx.formatters.CurrencyFormatter;
	
	public class Recurring
	{
		private var _rmt:RmtRecurring;
		private var _bDirty:Boolean;
		private var usd:CurrencyFormatter;
		public function Recurring(obj:Object)
		{
			_rmt = new RmtRecurring;
			_bDirty = false;
			if(obj != null)
			{
				_rmt.Amount = obj.Amount;
				_rmt.ChargeItemID = obj.ChargeItemID;
				_rmt.ChargeMemberRecurringID = obj.ChargeMemberRecurringID;
				_rmt.UserID = obj.UserID;
				_rmt.UserName = obj.UserName;
				_rmt.MemberType = obj.MemberType;
			}
			// Set up Formatters
				usd = new CurrencyFormatter;
				usd.precision="2"; 
        		usd.currencySymbol="";
        		usd.decimalSeparatorFrom=".";
        		usd.decimalSeparatorTo=".";
        		usd.useNegativeSign=false; 
        		usd.useThousandsSeparator=true;
        		usd.alignSymbol="left";
		}
		/*
			Setters & Getters
		*/
		public function set Amount(n:Number):void
		{
			_rmt.Amount = n;
			_bDirty = true;
		}
		public function get Amount():Number
		{
			return _rmt.Amount;
		}
		public function set strAmount(s:String):void
		{
			_rmt.Amount = Number(s);
			_bDirty = true;
		}
		public function get strAmount():String
		{
			return usd.format(_rmt.Amount);
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
		public function set ChargeMemberRecurringID(i:int):void
		{
			_rmt.ChargeMemberRecurringID = i;
		}
		public function get ChargeMemberRecurringID():int
		{
			return _rmt.ChargeMemberRecurringID;
		}
		
		public function set MemberType(s:String):void
		{
			_rmt.MemberType = s;
		}
		public function get MemberType():String
		{
			return _rmt.MemberType;
		}
		public function get MemberRecurring():RmtRecurring
		{
			return _rmt;
		}
		public function get DirtyFlag():Boolean
		{
			return _bDirty;
		}
	}
}