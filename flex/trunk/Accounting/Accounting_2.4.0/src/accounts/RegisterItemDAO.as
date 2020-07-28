package accounts
{
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.formatters.CurrencyFormatter;
	import mx.rpc.events.ResultEvent;
   	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

		// Control Register Items 
	[Bindable]
	public class RegisterItemDAO
	{
		private var _RegisterItem:RegisterItem;
		private var _fDirty:Boolean;					// Flag to see if this memo already entered
		private static var usd:CurrencyFormatter;
		private var rsi:RemoteObject;

		// Constructor
		public function RegisterItemDAO(ri:Object)
		{ 
			_RegisterItem = new RegisterItem();
			if(ri != null)
			{
				_RegisterItem.RegisterItemID = ri.RegisterItemID;
				_RegisterItem.RegisterID = ri.RegisterID;
				_RegisterItem.dFlag = ri.dFlag;							// 2/2/09 - Init as NOT deleted
				_RegisterItem.EntityID = ri.EntityID;					// 2/16/09 - New, added
				_RegisterItem.AccountCode = ri.AccountCode;
				_RegisterItem.GL_Account = ri.GL_Account;
				_RegisterItem.GL_AccountID = ri.GL_AccountID;
				_RegisterItem.GL_AccountTypeID = ri.GL_AccountTypeID;
				_RegisterItem.Memo = (ri.Memo == null) ? "" : ri.Memo;
				_RegisterItem.Description = (ri.Description == null) ? "" : ri.Description;
				_RegisterItem.Credit = ri.Credit;
				_RegisterItem.Debit = ri.Debit;
			
//				if (ri.Credit != 0) 						//Reversed in RegisterItem
//					_RegisterItem.Amount = ri.Credit;
//				else 
//					_RegisterItem.Amount = ri.Debit;
			}
			// Set up Formatters
			usd = new CurrencyFormatter;
			usd.precision="2"; 
       		usd.currencySymbol="";
       		usd.decimalSeparatorFrom=".";
       		usd.decimalSeparatorTo=".";
       		usd.useNegativeSign=true; 
       		usd.useThousandsSeparator=true;
       		usd.thousandsSeparatorFrom=""
		    usd.thousandsSeparatorTo=","
       		usd.alignSymbol="left";
		}
		
/* -----------------------------------------------------------------------------------------
		Public Setters & Getters
------------------------------------------------------------------------------------------ */

// fDirty
		public function set fDirty(b:Boolean):void
		{
			_fDirty = b;
		}
		public function get fDirty():Boolean
		{
			return _fDirty;
		}

// RegisterItemID
		public function set RegisterItemID(i:int):void
		{
			_RegisterItem.RegisterItemID = i;
		}
		public function get RegisterItemID():int
		{
			return _RegisterItem.RegisterItemID;
		}

// RegisterID
		public function set RegisterID(i:int):void
		{
			_RegisterItem.RegisterID = i;
		}
		public function get RegisterID():int
		{
			return _RegisterItem.RegisterID;
		}
	
// dFlag
		public function set dFlag(f:Boolean):void				// 2/2/09 - Added
		{
			_RegisterItem.dFlag = f;
		}
		public function get dFlag():Boolean
		{
			return _RegisterItem.dFlag;
		}

// EntityID
		public function set EntityID(i:int):void
		{
			_RegisterItem.EntityID = i;
		}
		public function get EntityID():int
		{
			return _RegisterItem.EntityID;
		}

// AccountCode
		public function set AccountCode(i:int):void
		{
			_RegisterItem.AccountCode = i;
		}
		public function get AccountCode():int
		{
			return _RegisterItem.AccountCode;
		}

// GL_Account
		public function set GL_Account(s:String):void
		{
			_RegisterItem.GL_Account = s;
		}
		public function get GL_Account():String
		{
			return _RegisterItem.GL_Account;
		}

// GL_AccountTypeID
		public function set GL_AccountTypeID(i:int):void
		{
			_RegisterItem.GL_AccountTypeID = i;
		}
		public function get GL_AccountTypeID():int
		{
			return _RegisterItem.GL_AccountTypeID;
		}

// GL_AccountID
		public function set GL_AccountID(i:int):void
		{
			_RegisterItem.GL_AccountID = i;
		}
		public function get GL_AccountID():int
		{
			return _RegisterItem.GL_AccountID;
		}

// Memo
		public function set Memo(s:String):void
		{
			_RegisterItem.Memo = s;
		}
		public function get Memo():String
		{
			return _RegisterItem.Memo;
		}

// Description
		public function set Description(s:String):void
		{
			_RegisterItem.Description = s;
		}
		public function get Description():String
		{
			return _RegisterItem.Description;
		}


// Credit
		public function set Credit(n:Number):void
		{
			_RegisterItem.Credit = n;
		}
		public function get Credit():Number
		{
			return _RegisterItem.Credit;
		}

// Debit
		public function set Debit(n:Number):void
		{
			_RegisterItem.Debit = n;
		}
		public function get Debit():Number
		{
			return _RegisterItem.Debit;
		}
		
	}	
}