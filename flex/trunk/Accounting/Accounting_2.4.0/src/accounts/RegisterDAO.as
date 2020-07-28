package accounts
{
	import mx.controls.Alert;
	import mx.formatters.CurrencyFormatter;
	// Use to add new Register Items 

	[Bindable]   
	public class RegisterDAO
	{
		private var _Register:Register;
		private var _SplitTotal:Number;						// This is the Total Amount of the SplitItems
		public var _Balance:Number = 0;						// This is the Total Amount of the SplitItems

		private static var usd:CurrencyFormatter;
		// Constructor 
		public function RegisterDAO(r:Object, _dsn:String, _ep:String)
		{
			_Register = new Register();
			if(r != null)
			{
				_Register.RegisterID = r.RegisterID;
				_Register.RegDate = r.RegDate;
				_Register.InvoiceGrpID = r.InvoiceGrpID;
				_Register.RefNum = (r.RefNum == null) ? "" : r.RefNum;
				_Register.Memo = (r.Memo == null) ? "" : r.Memo;
				_Register.Description = (r.Description == null) ? "" : r.Description;
				_Register.DueDate = r.DueDate;
				_Register.EntityID = r.EntityID;
				_Register.fEdit = r.fEdit;
				_Register.AccountCode = r.AccountCode;
				_Register.GL_AccountID = r.GL_AccountID;
				_Register.GL_Account = r.GL_Account;
				_Register.GL_ParentAccount = r.GL_ParentAccount;
				_Register.GL_AccountTypeID = r.GL_AccountTypeID;
				_Register.bitIsProforma = r.bitIsProforma;
				_Register.bitIsSplit = r.bitIsSplit;
				_Register.bitIsDeposit = r.bitIsDeposit;
				_Register.bitIsCheck = r.bitIsCheck;
				_Register.bitIsCleared = r.bitIsCleared;
				_Register.Debit = r.Debit;
				_Register.Credit = r.Credit;
				_Register.RegisterItems = new Array();
				//TW: new for 2.5.3 
				if(r.fBitLocked != null) {
					_Register.fBitLocked = r.fBitLocked;
				}
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
       
//	    	// Set up remote object
//      		rsi = new RemoteObject;
//       		rsi.destination="ColdFusion";
//      		rsi.addEventListener(FaultEvent.FAULT,remoteError);
//	     		rsi.addEventListener(ResultEvent.RESULT, riResult);
//       		rsi.source = _dsn + ".CFC.RegisterItemDAO";
//      		rsi.endpoint = _ep;
		}
		
		public function toString():String {
			return _Register.toString();
		}
		
/* -----------------------------------------------------------------------------------------
	Public Setters & Getters
------------------------------------------------------------------------------------------ */

// RegisterID
		public function set RegisterID(i:int):void
		{
			_Register.RegisterID = i;
		}
		public function get RegisterID():int 
		{
			return _Register.RegisterID;
		}

// RegDate - When the PopUp RegDate is changed. Converts date to string.
		public function set RegDate(s:String):void 
		{
			_Register.RegDate = s;
		}
		public function set dRegDate(d:Date):void 
		{
			if(d is Date)
				_Register.RegDate = d.toDateString();
			else
				Alert.show(d.toDateString() + " is not a valid date");	
		}
		public function get RegDate():String 
		{
			return (_Register.RegDate);
		}
		public function get dRegDate():Date 
		{
			var d:Date;
			
			d = new Date( _Register.RegDate );
			return (d);
		}
		
// RefNum
		public function set RefNum(s:String):void
		{
			_Register.RefNum = s;
		}
		public function get RefNum():String
		{
			return _Register.RefNum;
		}
	
// GL_AccountID
		public function set GL_AccountID(i:int):void
		{
			_Register.GL_AccountID = i;
		}
		public function get GL_AccountID():int
		{
			return _Register.GL_AccountID;
		}

// GL_Account
		public function set GL_Account(s:String):void
		{
			_Register.GL_Account = s;
		}
		public function get GL_Account():String
		{
			return _Register.GL_Account;
		}

// GL_ParentAccount
		public function set GL_ParentAccount(s:String):void
		{
			_Register.GL_ParentAccount = s;
		}
		public function get GL_ParentAccount():String
		{
			return _Register.GL_ParentAccount;
		}

// AccountCode
		public function set AccountCode(i:int):void
		{
			_Register.AccountCode = i;
		}
		public function get AccountCode():int
		{
			return _Register.AccountCode;
		}

// GL_AccountTypeID
		public function set GL_AccountTypeID(i:int):void
		{
			_Register.GL_AccountTypeID = i;
		}
		public function get GL_AccountTypeID():int
		{
			return _Register.GL_AccountTypeID;
		}

// EntityID
		public function set EntityID(i:int):void
		{
			_Register.EntityID = i;
		}
		public function get EntityID():int
		{
			return _Register.EntityID;
		}

// fEdit
		public function set fEdit(i:int):void
		{
			_Register.fEdit = i;
		}
		public function get fEdit():int
		{
			return _Register.fEdit;
		}

// Description
		public function set Description(s:String):void
		{
			_Register.Description = s;
		}
		public function get Description():String
		{
			return _Register.Description;
		}

// Memo
		public function set Memo(s:String):void
		{
			_Register.Memo = s;
		}
		public function get Memo():String
		{
			return _Register.Memo;
		}
		
// DueDate
		public function set DueDate(s:String):void 
		{
			_Register.DueDate = s;
		}
		public function set dDueDate(d:Date):void 
		{
			if(d is Date)
				_Register.DueDate = d.toDateString();
			else
				Alert.show(d.toDateString() + " is not a valid date");	
		}
		public function get DueDate():String 
		{
			return (_Register.DueDate);
		}
		public function get dDueDate():Date 
		{
			var d:Date;
			
			d = new Date( _Register.DueDate );
			return (d);
		}
		
// IsProforma
		public function set bitIsProforma(b:Boolean):void
		{
			_Register.bitIsProforma = b;
		}
		public function get bitIsProforma():Boolean
		{
			return _Register.bitIsProforma;
		}

// IsSplit
		public function set bitIsSplit(b:Boolean):void
		{
			_Register.bitIsSplit = b;
		}
		public function get bitIsSplit():Boolean
		{
			return _Register.bitIsSplit;
		}
// IsCheck
		public function set bitIsCheck(b:Boolean):void
		{
			_Register.bitIsCheck = b;
		}
		public function get bitIsCheck():Boolean
		{
			return _Register.bitIsCheck;
		}

// IsDeposit
		public function set bitIsDeposit(b:Boolean):void
		{
			_Register.bitIsDeposit = b;
		}
		public function get bitIsDeposit():Boolean
		{
			return _Register.bitIsDeposit;
		}

// IsCleared
		public function set bitIsCleared(b:Boolean):void
		{
			_Register.bitIsCleared = b;
		}
		public function get bitIsCleared():Boolean
		{
			return _Register.bitIsCleared;
		}


// Debit
		public function set Debit(n:Number):void 
		{
			_Register.Debit = n;
		}
		public function get Debit():Number 
		{
			return _Register.Debit;
		}
		public function get strDebit():String 
		{
			return usd.format(_Register.Debit);
		}

// Credit
		public function set Credit(n:Number):void 	
		{
			_Register.Credit = n;
		}
		public function get Credit():Number 
		{
			return _Register.Credit;
		}
		public function get strCredit():String 
		{
			return usd.format(_Register.Credit);
		}

// Balance
		public function set Balance(n:Number):void 
		{
			_Balance = n;
		}
		public function get Balance():Number 
		{
			return _Balance;
		}
		public function get strBalance():String 
		{
			return usd.format(_Balance);					//Check this!!!!!
		}
		
// TotalAmount
//		public function TotalAmount():Number 
//		{
//			var i:int, len:int;
//			var total:Number;
//			
//			total = 0;
//			len = _Register.RegisterItems.length;
//			for(i=0; i<len; i++) {
//				if (!_Register.RegisterItems[i].dFlag)				//Don't add in deleted items
//					total += _Register.RegisterItems[i].Amount;
//				}
//			_SplitTotal = total;
//			return total;
//		}

// SplitItems - ????  Added 
//		public function set SplitItems(si:Array):void 
//		{
//			_Register.RegisterItems = si;
//		}
//		public function get SplitItems():Array 
//		{
//			return _Register.RegisterItems;
//		}
	
// RmtRegister - Used to Pass Register Structure to Args
		public function get RmtRegister():Register 
		{
			return _Register;
		}

// RegisterItems
		public function get RegisterItems():Array 
		{
			return _Register.RegisterItems;
		}
		
		//TW: Added in 2.5.3
		// fBitLocked
		public function set fBitLocked(b:Boolean):void
		{
			_Register.fBitLocked = b;
		}
		public function get fBitLocked():Boolean
		{
			return _Register.fBitLocked;
		}

	}
}