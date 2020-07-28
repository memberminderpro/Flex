package InfusionGrp
{
	import flash.events.Event;
	[Bindable]
	public class InvoiceClass
	{
		import mx.formatters.CurrencyFormatter;
		import mx.formatters.DateFormatter;
		import InfusionGrp.ChargeItem;
		import flash.events.Event;
		import com.adobe.serialization.json.JSON;
		private var _Period:String;
		private var _Amount:String;
		private var _NumAmount:Number;
		private var _Description:String;
		private var _ModifiedBy:int;
		private var _InvoiceGrpID:int;
		private var _IsProforma:String;
		private var _AccountID:int;
		private var _Message:String;
		private var _DueDate:Date;
		private var _InvoiceDate:Date;
		private var _ClubID:int;
		private var _IncZeroAmts:String;
		private var _Created_Tmstmp:Date;
		private var _CreatedBy:int;
		private var _Modified_Tmstmp:Date;
		private var _IsPosted:String;
		private var _InvoiceGrp:String;
		private var _DatePosted:Date;
		private static var dollar:CurrencyFormatter;
		private static var invDate:DateFormatter;
		
		// Constructor
		public function InvoiceClass(o:Object):void
		{
			// Fill initial values
			_Period = o.Period;
			_Amount = o.Amount;
			_Description = o.Description;
			_ModifiedBy = o.ModifiedBy;
			_InvoiceGrpID = o.InvoiceGrpID;
			_IsProforma = o.IsProforma;
			_AccountID = o.AccountID;
			_Message = o.Message;
			_DueDate = cfDate(o.DueDate);		// Normalize
			_InvoiceDate = cfDate(o.InvoiceDate);
			_ClubID = o.ClubID;
			_IncZeroAmts = o.IncZeroAmts;
			_Created_Tmstmp = cfDate(o.Created_Tmstmp);
			_CreatedBy = o.CreatedBy;
			_Modified_Tmstmp = cfDate(o.Date);
			_IsPosted = o.IsPosted;
			_InvoiceGrp = o.InvoiceGrp;
			_DatePosted = cfDate(o.DatePosted);
			// Set up Formatters
			dollar = new CurrencyFormatter;
			dollar.precision="2"; 
        	dollar.currencySymbol="$";
        	dollar.decimalSeparatorFrom=".";
        	dollar.decimalSeparatorTo=".";
        	dollar.useNegativeSign=true; 
        	dollar.useThousandsSeparator=true;
        	dollar.alignSymbol="left";
        	invDate = new DateFormatter;
        	invDate.formatString="MMM DD, YYYY";
		}
		private static function usd(d:Number):String
		{
			return dollar.format(d);
		}
		private function cfDate(d:Date):Date
		{
			var _cfDate:Date;
			if(d != null)
			{
				_cfDate = new Date(d.fullYearUTC, d.monthUTC, d.dateUTC);
			}
			return _cfDate;
		}
		/*
			Setter / Getter routines for variables
		*/
		public function set Period(s:String):void
		{
			_Period = s;
		}
		public function get Period():String
		{
			return _Period;
		}
		public function set Amount(s:String):void
		{
			_Amount = s;
			_NumAmount = Number(s);
		}
		public function get Amount():String
		{
			return _Amount;
		}
		public function get usdAmount():String
		{
			return usd(_NumAmount);
		}
		public function set Description(s:String):void
		{
			_Description = s;
		}
		public function get Description():String
		{
			return _Description;
		}
		public function set ModifiedBy(i:int):void
		{
			_ModifiedBy = i;
		}
		public function get ModifiedBy():int
		{
			return _ModifiedBy;
		}
		public function set InvoiceGrpID(i:int):void
		{
			_InvoiceGrpID = i;
		}
		public function get InvoiceGrpID():int
		{
			return _InvoiceGrpID;
		}
		public function set IsProforma(s:String):void
		{
			_IsProforma = s;
		}
		public function get IsProforma():String
		{
			return _IsProforma;
		}
		public function set AccountID(i:int):void
		{
			_AccountID = i;
		}
		public function get AccountID():int
		{
			return _AccountID;
		}
		public function set Message(s:String):void
		{
			_Message = s;
		}
		public function get Message():String
		{
			return _Message;
		}
		public function set DueDate(d:Date):void
		{
			_DueDate = cfDate(d);
		}
		public function get DueDate():Date
		{
			return _DueDate;
		}
		public function get fmtDueDate():String
		{
			return invDate.format(_DueDate);
		}
		public function set InvoiceDate(d:Date):void
		{
			_InvoiceDate = cfDate(d);
		}
		public function get InvoiceDate():Date
		{
			return _InvoiceDate;
		}
		public function get fmtInvoiceDate():String
		{
			return invDate.format(_InvoiceDate);
		}
		public function set ClubID(i:int):void
		{
			_ClubID = i;
		}
		public function get ClubID():int
		{
			return _ClubID;
		}
		public function set IncZeroAmts(s:String):void
		{
			_IncZeroAmts = s;
		}
		public function get IncZeroAmts():String
		{
			return _IncZeroAmts;
		}
		public function set Created_Tmstmp(d:Date):void
		{
			_Created_Tmstmp = cfDate(d);
		}
		public function get Created_Tmstmp():Date
		{
			return _Created_Tmstmp;
		}
		public function set CreatedBy(i:int):void
		{
			_CreatedBy = i;
		}
		public function get CreatedBy():int
		{
			return _CreatedBy;
		}
		public function set Modified_Tmstmp(d:Date):void
		{
			_Modified_Tmstmp = cfDate(d);
		}
		public function get Modified_Tmstmp():Date
		{
			return _Modified_Tmstmp;
		}
		public function set IsPosted(s:String):void
		{
			_IsPosted = s;
		}
		public function get IsPosted():String
		{
			return _IsPosted;
		}
		public function set InvoiceGrp(s:String):void
		{
			_InvoiceGrp = s;
		}
		public function get InvoiceGrp():String
		{
			return _InvoiceGrp;
		}
		public function set DatePosted(d:Date):void
		{
			_DatePosted = cfDate(d);
		}
		public function get DatePosted():Date
		{
			return _DatePosted;
		}
		public function get fmtDatePosted():String
		{
			return invDate.format(_DatePosted);
		}
	}
}