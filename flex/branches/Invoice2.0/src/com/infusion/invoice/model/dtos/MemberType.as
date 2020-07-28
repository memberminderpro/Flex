package com.infusion.invoice.model.dtos
{
	import mx.formatters.CurrencyFormatter;
	
	public class MemberType
	{
		private var _Amount:Number;
		private var _ChargeItemID:int;
		private var _ChargeMemberTypeID:int;
		private var _MemberType:String;
		private var _MemberTypeID:int;
		private var usd:CurrencyFormatter;
		
		public function MemberType(obj:Object)
		{
			if(obj != null)
			{
				_Amount = obj.Amount;
				_ChargeItemID = obj.ChargeItemID;
				_ChargeMemberTypeID = obj.ChargeMemberTypeID;
				_MemberType = obj.MemberType;
				_MemberTypeID = obj.MemberTypeID;
			}
			// Set up Formatters
				usd = new CurrencyFormatter;
				usd.precision="2"; 
        		usd.currencySymbol="";
        		usd.decimalSeparatorFrom=".";
        		usd.decimalSeparatorTo=".";
        		usd.useNegativeSign=true; 
        		usd.useThousandsSeparator=true;
        		usd.alignSymbol="left";
		}
		// Setters & Getters
		public function set Amount(n:Number):void
		{
			_Amount = n;
		}
		public function get Amount():Number
		{
			return _Amount;
		}
		public function set strAmount(s:String):void
		{
			_Amount = Number(s);
		}
		public function get strAmount():String
		{
			return usd.format(_Amount);
		}
		public function set ChargeItemID(i:int):void
		{
			_ChargeItemID = i;
		}
		public function get ChargeItemID():int
		{
			return _ChargeItemID;
		}
		public function set ChargeMemberTypeID(i:int):void
		{
			_ChargeMemberTypeID = i;
		}
		public function get ChargeMemberTypeID():int
		{
			return _ChargeMemberTypeID;
		}
		public function set Type(s:String):void
		{
			_MemberType = s;
		}
		public function get Type():String
		{
			return _MemberType;
		}
		public function set MemberTypeID(i:int):void
		{
			_MemberTypeID = i;
		}
		public function get MemberTypeID():int
		{
			return _MemberTypeID;
		}
	}
}