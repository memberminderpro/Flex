package InfusionGrp
{
	import flash.events.Event;
	[Bindable]
	public class MemberClass
	{
		import mx.formatters.CurrencyFormatter;
		import mx.formatters.DateFormatter;
		import InfusionGrp.ChargeItem;
		import flash.events.Event;
		import com.adobe.serialization.json.JSON;
		
		import mx.controls.Alert;
		private var _CountryName:String;
		private var _CountryCode:String;
		private var _TollFree:String;
		private var _UserID:int;
		private var _UserName:String;
		private var _Prefix:String;
		private var _HomePhone:String;
		private var _OfficePhone:String;
		private var _CellPhone:String;
		private var _Fax:String;
		private var _Email:String;
		private var _addr1:String;
		private var _addr2:String;
		private var _City:String;
		private var _State:String;
		private var _Zip:String;
		private var _FName:String;
		private var _ClubName:String;
		private var _Prov:String;
		private var _ClubID:int;
		private var _iAmount:int;
		private var _strAmount:String;
		private var _MemberType:String;
		private var _MemberTypeID:int;
		private var _IsSelected:Boolean;
		private var _dormant:Boolean;
		private var _Total:Number;
		private  var _subTotal:String;
		private var _subTotalAmt:Number;
		private var _taxTotal:Number;
		private var _charges:Array;			//Array of Charge Items (ChargeItems Class)
		private var _Invoice:Object;		//Invoice Object
		private var _invoiceID:int;			//ID of associated Invoice
		private var _invoiceGrpID:int;		//ID of Invoice Group
		private var _dsn:String;
		private var _endPoint:String;
		private var _customMsg:String;
		private static var dollar:CurrencyFormatter;
		private static var invDate:DateFormatter;
		private static var perMemberType:int = 2;
		// Constructor
		public function MemberClass(a:Object):void
		{
			// Fill initial values
			_CountryName = a.CountryName;
			_CountryCode = a.CountryCode;
			_TollFree = a.TollFreeNumber;
			_Prefix = a.Prefix;
			_ClubName = a.ClubName;
			_iAmount = a.Amount;
			_strAmount = String(a.Amount);
			_MemberType = a.MemberType;
			_MemberTypeID = a.MemberTypeID;
			_ClubID = a.ClubID;
			_UserID = a.UserID;
			_UserName = a.UserName;
			_FName = a.FName;
			_addr1 = a.Address1;
			_addr2 = a.Address2;
			_City = a.City;
			_State = a.StateCode;
			_Zip = a.PostalZip;
			_Prov = a.ProvOrOther;
			_HomePhone = a.HomePhone;
			_OfficePhone = a.OfficePhone;
			_CellPhone = a.CellPhone;
			_Fax = a.FaxNumber;
			_Email = a.Email;
			_customMsg = "";
			_dormant = false;
			_charges = new Array();
			
			//Set Invoice ID
			_invoiceID = a.InvoiceID;			//ID of associated Invoice
			_invoiceGrpID = a.InvoiceGrpID;		//ID of Invoice Group
		
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
		/*
			Setter / Getter routines for variables
		*/
		public function set InvoiceID(i:int):void
		{
			_invoiceID = i;
		}
		public function get InvoiceID():int
		{
			return _invoiceID;
		}
		public function set InvoiceGrpID(i:int):void
		{
			_invoiceGrpID = i;
		}
		public function get InvoiceGrpID():int
		{
			return _invoiceGrpID;
		}
		public function set Dormant(b:Boolean):void
		{
			_dormant = b;
		}
		public function get Dormant():Boolean
		{
			return _dormant;
		}
		public function set customMsg(s:String):void
		{
			_customMsg = s;
		}
		public function get customMsg():String
		{
			return _customMsg;
		}
		public function set dsn(s:String):void
		{
			_dsn = s;
		}
		public function set endPoint(s:String):void
		{
			_endPoint = s;
		}
		public function set ClubName(s:String):void
		{
			_ClubName = s;
		}
		public function get ClubName():String
		{
			return _ClubName;
		}
		public function set ClubID(i:int):void
		{
			_ClubID = i;
		}
		public function get ClubID():int
		{
			return _ClubID;
		}
		public function set Amount(s:String):void
		{
			_strAmount = s;
			_iAmount = int(s);
		}
		public function get Amount():String
		{
			return dollar.format(_strAmount);
		}
		public function get iAmount():int
		{
			return _iAmount;
		}
		public function set MemberType(s:String):void
		{
			_MemberType = s;
		}
		public function get MemberType():String
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
		public function set UserID(i:int):void
		{
			_UserID = i;
		}
		public function get UserID():int
		{
			return _UserID;
		}
		public function set UserName(s:String):void
		{
			_UserName = s;
		}
		public function get UserName():String
		{
			return _UserName;
		}
		public function set CountryName(s:String):void
		{
			_CountryName = s;
		}
		public function get CountryName():String
		{
			return _CountryName;
		}
		public function set CountryCode(s:String):void
		{
			_CountryCode = s;
		}
		public function get CountryCode():String
		{
			return _CountryCode;
		}
		public function set TollFree(s:String):void
		{
			_TollFree = s;
		}
		public function get TollFree():String
		{
			return _TollFree;
		}
		public function set Prefix(s:String):void
		{
			_Prefix = s;
		}
		public function get Prefix():String
		{
			return _Prefix;
		}
		public function set Addr1(s:String):void
		{
			_addr1 = s;
		}
		public function get Addr1():String
		{
			return _addr1;
		}
		public function set Addr2(s:String):void
		{
			_addr2 = s;
		}
		public function get Addr2():String
		{
			return _addr2;
		}
		public function set City(s:String):void
		{
			_City = s;
		}
		public function get City():String 
		{
			return _City
		}
		public function set State(s:String):void
		{
			_State = s;
		}
		public function get State():String
		{
			return _State;
		}
		
		public function set ProvOrOther(s:String):void
		{
			_Prov = s;
		}
		public function get ProvOrOther():String
		{
			return _Prov;
		}
		public function set HomePhone(s:String):void
		{
			_HomePhone = s;
		}
		public function get HomePhone():String
		{
			return _HomePhone;
		}
		public function set OfficePhone(s:String):void
		{
			_OfficePhone = s;
		}
		public function get OfficePhone():String
		{
			return _OfficePhone;
		}
		public function set CellPhone(s:String):void
		{
			_CellPhone = s;
		}
		public function get CellPhone():String
		{
			return _CellPhone;
		}
		public function set Email(s:String):void
		{
			_Email = s;
		}
		public function get Email():String
		{
			return _Email;
		}
		public function set IsSelected(b:Boolean):void
		{
			_IsSelected = b;
		}
		public function get IsSelected():Boolean
		{
			return _IsSelected;
		}
		public function set Zip(s:String):void
		{
			_Zip = s;
		}
		public function get Zip():String
		{
			return _Zip;
		}
		public function set Charge(ar:Array):void
		{
			_charges = ar;
		}
		public function get Charge():Array
		{
				return _charges;
		}
		public function addCharge(ci:ChargeItem):void
		{
			ci.ItemMemberTypeID = _MemberTypeID;
			_charges.push(ci);		// Add Charge
		}
		public function delCharge(idx:int):void
		{
			var i:int, len:int;
			len = _charges.length;
			for(i=0; i<len; i++)
			{
				if(_charges[i].ItemChargeID == idx)		//remove
				{
					_charges.splice(i, 1);
					break;
				}
			}
		}
		public function get Total():String
		{
			var i:int, len:int;
			var amt:Number;
			var s:String;
			len = _charges.length;
			_Total = 0;
			for(i=0; i<len; i++)
			{
				try {
				amt = Number(_charges[i].InvoiceAmtNum);
				} catch(e:Error) {
					//Alert.show("Failed to Get Total of "+i+" of list: "+len+", charges: "+_charges[i].toString());
					amt = 0;
				}
				_Total += amt;
			}
			_subTotalAmt = _Total;
			s = _Total.toString();
			_subTotal = s;
			return s;
		}
		public function set MemInvoice(obj:Object):void
		{
			_Invoice = obj;
		}
		public function get MemInvoice():Object
		{
			return _Invoice;
		}
		public function InvoiceDate():String 
		{
			var tmpDate:Date;
			var fmtDate:String = "";
			if(_Invoice.InvoiceDate != null) {
				tmpDate = new Date(_Invoice.InvoiceDate);
				fmtDate = invDate.format(tmpDate);
			}
			
			return fmtDate;
		}
		public function DueDate():String
		{
			var tmpDate:Date;
			var fmtDate:String = "";
			if(_Invoice.DueDate != null) {
				tmpDate = new Date(_Invoice.DueDate);
				fmtDate = invDate.format(tmpDate);
			}
			
			return fmtDate;
		}
		public function InvoiceNm():String
		{
			var grpName:String = "";
			if(_Invoice.InvoiceGrp != null) {
				grpName = _Invoice.InvoiceGrp;
			}
			return grpName;
		}
		public function chkbox(e:Event):void
		{
			_IsSelected = e.currentTarget.selected;
			e.currentTarget.outerDocument.selMembers();
		}
		public function get subTotal():String
		{
			return _subTotal;
		}
		public function get taxTotal():String
		{
			var i:int, len:int;
			var taxAmt:Number;
			
			if(_charges != null)
			{
				len = _charges.length;
				taxAmt = 0;
				for(i=0; i<len; i++)
				{
					var amt:Number = 0;
					try {
						taxAmt += _charges[i].ItemTaxAmt
					} catch(e:Error) {
						//Alert.show("Failed to Get Total of "+i+" of list: "+len+", charges: "+_charges[i].toString());
						amt = 0;
					}
				}
				_taxTotal = taxAmt;
			}
			else
			{
				taxAmt = 0;
				_taxTotal = 0;
			}
			return taxAmt.toString();
		}
		public function get chargeTotal():String
		{
			var grndTotal:Number;
			this.Total;
			grndTotal = _taxTotal + _subTotalAmt;
			return grndTotal.toString();
		}
		
		public function toString():String {
			return _UserName+", Charges: "+_charges;
			
		}
		
	}
}