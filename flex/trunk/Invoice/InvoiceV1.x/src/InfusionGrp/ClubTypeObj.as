package InfusionGrp
{
	import mx.formatters.CurrencyFormatter;
	
	public class ClubTypeObj
	{
		private var _Amount:Number = 0;
		private var _ChargeItemID:int;
		private var _ChargeClubTypeID:int;
		private var _ClubType:String;
		private var _ClubTypeID:int;
		private var usd:CurrencyFormatter;
		
		public function ClubTypeObj(obj:Object)
		{
			if(obj != null)
			{
				_Amount = obj.Amount;
				_ChargeItemID = obj.ChargeItemID;
				_ChargeClubTypeID = obj.ChargeClubTypeID;
				_ClubType = obj.ClubType;
				_ClubTypeID = obj.ClubTypeID;
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
		public function set ChargeClubTypeID(i:int):void
		{
			_ChargeClubTypeID = i;
		}
		public function get ChargeClubTypeID():int
		{
			return _ChargeClubTypeID;
		}
		
		
		public function set ClubType(s:String):void
		{
			_ClubType = s;
		}
		public function get ClubType():String
		{
			return _ClubType;
		}
		
		public function set ClubTypeID(i:int):void
		{
			_ClubTypeID = i;
		}
		public function get ClubTypeID():int
		{
			return _ClubTypeID;
		}
	}
}