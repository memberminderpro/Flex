package com.infusion.invoice.model.dtos
{
	import com.infusion.invoice.model.dtos.ChargeMemberType;
	import com.infusion.invoice.model.dtos.SelectedMember;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.*;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.*;
	import mx.formatters.CurrencyFormatter;
	import mx.messaging.messages.RemotingMessage;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
		
	[Bindable]
	public class ChargeItem
	{
		public var _invoiceItem:InvoiceItem;
		public var amount:String;
		public var _taxMin:String;
		public var _taxMax:String;
		public var _taxPercent:String;
		public var _isActive:String;
		public var _chargeItem:String;
		public var _chargeItemID:int;
		public var _chargeTypeID:int;
		public var _chargeType:String;
		public var _glAccount:String;
		public var _glAccountID:int;
		public var _clubID:int;
		public var _dateTo:Date;
		public var _dateFrom:Date;
		public var _dateRngID:int;
		public var _dirty:Boolean;
		public var _isSelected:Boolean;
		public var _index:int;
		public var _memberType:ArrayCollection;
		public var _memberTypeID:int;
		public var _chargeMemberType:RemoteObject;
		public var _memberRecurring:RemoteObject;
		public var _memberSelected:RemoteObject;
		public var _mealcodeID:int;
		public var _dsn:String;
		public var _callBack:Function;
		public var _pending:Boolean;
		public var _arSend:Array;
		public var _displayType:int;		// Defines components to display
		public static const perMemberType:int = 2;
		public static var _nxIdx:int;
		public static var dollar:CurrencyFormatter;

		// Constructor
		public function ChargeItem(obj:Object)
		{
			_dirty = true;
			if(obj != null)
			{
				// Items from server
				amount = obj.Amount;
				_chargeItem = obj.ChargeItem;
				_chargeItemID = obj.ChargeItemID;
				_chargeTypeID = obj.ChargeTypeID;
				_clubID = obj.ClubID;
				_dateFrom = obj.DateFrom;
				_dateRngID = obj.DateRangeID;
				_dateTo = obj.DateTo;
				_glAccount = obj.GL_Account;
				_glAccountID = obj.GL_AccountID;
				_taxMax = obj.TaxMax;
				_taxMin = obj.TaxMin;
				_taxPercent = obj.TaxPercent;
				_mealcodeID = obj.MealCodeID;
				_isActive = obj.IsActive;
				_isSelected = false;
				_pending = false;
				_dirty = false;
			}
			_displayType = 1;		// Default
			_nxIdx++;
			_index = _nxIdx;
			// Set up Formatters
			//TODO needed here?  Should be in GUI only...
			dollar = new CurrencyFormatter;
			dollar.precision="2"; 
        	dollar.currencySymbol="";
        	dollar.decimalSeparatorFrom=".";
        	dollar.decimalSeparatorTo=".";
        	dollar.useNegativeSign=true; 
        	dollar.useThousandsSeparator=true;
        	dollar.alignSymbol="left";
        	// Set up Remote Object for charge items
//        	_chargeMemberType = new RemoteObject;
//        	_chargeMemberType.destination="ColdFusion";
//        	_chargeMemberType.addEventListener(FaultEvent.FAULT,remoteError);
//        	_chargeMemberType.addEventListener(ResultEvent.RESULT, memberTypeCFC);
//        	// Set up Remote Object for recurring items
//        	_memberRecurring = new RemoteObject;
//        	_memberRecurring.destination="ColdFusion";
//        	_memberRecurring.addEventListener(FaultEvent.FAULT, remoteError);
//        	_memberRecurring.addEventListener(ResultEvent.RESULT, memberRecurringCFC);
//        	// Set up Remote Object for Member Selected items
//        	_memberSelected = new RemoteObject;
//        	_memberSelected.destination="ColdFusion";
//        	_memberSelected.addEventListener(FaultEvent.FAULT, remoteError);
//        	_memberSelected.addEventListener(ResultEvent.RESULT, memberSelectedCFC);
		}
		
		public function toString():String {
			return "\nChargeItem: "+_chargeItem+", "+amount;
		}
		private static function usd(d:Number):String
		{
			return dollar.format(d);
		}
		// Setters & Getters
		public function set CallBack(f:Function):void
		{
			_callBack = f;
		}
		public function set dsn(_dsn:String):void
		{
			_chargeMemberType.source = _dsn + ".CFC.ChargeMemberTypeDAO";
			_memberRecurring.source = _dsn + ".CFC.ChargeMemberRecurringDAO";
			_memberSelected.source = _dsn + ".CFC.ChargeMemberSelectedDAO";
		}
		public function set endPoint(s:String):void
		{
			_chargeMemberType.endpoint = s;
			_memberRecurring.endpoint = s;
			_memberSelected.endpoint = s;
		}
		public function ItemSaveQ(s:String):void
		{
			var dataString:String;
			var dataArray:Array;
			var dataObj:ChargeMember;
			var i:int, len:int;
			var obj:Object;
			//var _chargeItemID:int = _invoiceItem.ChargeItemID;
			
			if(_memberType.length > 0)
			{
				len = _memberType.length;
				dataArray = new Array(len);
				for(i=0; i<len; i++)
				{
					dataObj = new ChargeMember();
					_memberType[i].ChargeItemID = _chargeItemID;
					dataObj.Amount = _memberType[i].Amount;
					dataObj.ChargeItemID = _memberType[i].ChargeItemID;
					dataObj.ChargeMemberTypeID = _memberType[i].ChargeMemberTypeID;
					dataObj.MemberType = _memberType[i].MemberType;
					dataObj.MemberTypeID = _memberType[i].MemberTypeID;
					dataArray[i] = dataObj;
				}
				dataString = JSON.encode(dataArray);
				_pending = true;
		    	_chargeMemberType.SaveQ(dataString);
		 	}
		}
		//TODO what is difference between this and UpdateQ?
		public function RecurringSaveQ(ac:ArrayCollection, id:int):void
		{
			var i:int, len:int;
			var dataSend:String;	
			len = ac.length;
			_arSend = new Array();
			for(i=0; i<len; i++)
			{
				if(ac[i].Amount != 0)
				{
					ac[i].ChargeItemID = id;
					_arSend.push(ac[i].MemberRecurring);
				}
			}
			if(_arSend.length > 0)
			{
				dataSend = JSON.encode(_arSend);
				_memberRecurring.SaveQ(dataSend);
			}
		}
		public function RecurringUpdateQ(ac:ArrayCollection, id:int):void
		{
			var i:int, len:int;
			var dataSend:String;	
			len = ac.length;
			_arSend = new Array();
			for(i=0; i<len; i++)
			{
				if(ac[i].ChargeMemberRecurringID > 0 || ac[i].Amount != 0)
				{
					ac[i].ChargeItemID = id;
					_arSend.push(ac[i].MemberRecurring);
				}
			}
			if(_arSend.length > 0)
			{
				dataSend = JSON.encode(_arSend);
				_memberRecurring.SaveQ(dataSend);
			}
		}
		public function MemSelectedSaveQ(ac:ArrayCollection, id:int):void
		{
			var i:int, len:int;
			var dataSend:String;	
			len = ac.length;
			_arSend = new Array();
			var sm:SelectedMember;
			for(i=0; i<len; i++)
			{
				//Save All
				sm = ac[i] as SelectedMember;
				sm.ChargeItemID = id;
				_arSend.push(sm.MemberSelected);  
			}
			if(_arSend.length > 0)
			{
				dataSend = JSON.encode(_arSend);
				_memberSelected.SaveQ(dataSend);
			}
		}
		public function MemSelectedUpdateQ(ac:ArrayCollection, id:int):void
		{
			var i:int, len:int;
			var dataSend:String;	
			len = ac.length;
			_arSend = new Array();
			var idOrphans:ArrayCollection = new ArrayCollection();
			var sm:SelectedMember;
			for(i=0; i<len; i++)
			{
				//Only save updated people
				sm = ac[i] as SelectedMember;
				//TW: 01/27/2010
				// Add changed members no matter what
				//if(sm.ChargeMemberSelectedID > 0 && sm.DirtyFlag) {
				if(sm.DirtyFlag) {
					sm.ChargeItemID = id;
					_arSend.push(sm.MemberSelected); 
				} 
			}

			if(_arSend.length > 0)
			{
				dataSend = JSON.encode(_arSend);
				_memberSelected.SaveQ(dataSend);
			}
		}
		public function ItemAddInvoice(inv:Object):void
		{
			//TODO why does charge item contain invoice items?!
			_invoiceItem = new InvoiceItem();
			_invoiceItem.Amount = Number(inv.Amount);
			_invoiceItem.ChargeItemID = inv.ChargeItemID;
			_invoiceItem.Description = inv.Description;
			_invoiceItem.GL_Account = inv.GL_Account;
			_invoiceItem.GL_AccountID = inv.GL_AccountID;
			_invoiceItem.InvoiceID = inv.InvoiceID;
			_invoiceItem.InvoiceItemID = inv.InvoiceItemID;
			_invoiceItem.Qty = inv.Qty;
			_invoiceItem.Rate = Number(inv.Rate);
			_invoiceItem.Tax = Number(inv.Tax);
			_chargeItem = inv.Description;
		}
		public function ItemMemberTypeLookup():void
		{
			if(!_pending)
			{
				_chargeMemberType.Lookup(_chargeItemID);
			}
		}
		public function set ItemDisplayType(i:int):void
		{
			_displayType = i;
		}
		public function get ItemDisplayType():int
		{
			return _displayType;
		}
		public function set ItemMemberType(ar:ArrayCollection):void
		{
			_memberType = ar;
		}
		public function get ItemMemberType():ArrayCollection
		{
			return _memberType;
		}
		public function set ItemMemberTypeID(id:int):void
		{
			_memberTypeID = id;
		}
		public function get ItemMemberTypeLen():int
		{
			return _memberType.length;
		}
		public function set MealCodeID(i:int):void
		{
			_mealcodeID = i;
		}
		public function get MealCodeID():int
		{
			return _mealcodeID;
		}
		public function set ItemDescription(s:String):void
		{
			_chargeItem = s;
			if(_invoiceItem != null)
			{
				_invoiceItem.Description = s;
			}
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		public function get ItemDescription():String
		{
			return _chargeItem;
		}
		public function set ItemAccount(s:String):void
		{
			_glAccount = s;
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		public function get ItemAccount():String
		{
			return _glAccount;
		}
		public function set ItemAccountID(i:int):void
		{
			_glAccountID = i;
			if(_invoiceItem != null)
			{
				_invoiceItem.GL_AccountID = i;
			}
		}
		public function set ItemInvoiceAcct(s:String):void
		{
			_invoiceItem.GL_Account = s;
		}
		public function get ItemInvoiceAcct():String
		{
			return _invoiceItem.GL_Account;
		}
		public function get ItemAccountID():int
		{
			return _glAccountID;
		}
		public function set ItemRate(s:String):void
		{
			_invoiceItem.Rate = Number(s);
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		public function get ItemRate():String
		{
			var _rate:Number;
			_rate = _invoiceItem.Rate;
			return usd(_rate);
		}
		
		public function set ItemAmount(s:String):void
		{
			var i:int, len:int;
			amount = s;
			if(_chargeTypeID == perMemberType)
			{
				len = _memberType.length;
				for(i=0; i<len; i++)
				{
					if(_memberTypeID == _memberType[i].MemberTypeID)
					{
						_memberType[i].Amount = s;
						break;
					}
				}
			}
			_invoiceItem.Amount = Number(s);
		}
		
		public function get ItemRawAmount():String
		{
			return amount;
		}
		public function get ItemCalcAmt():String
		{
			var amt:Number;
			amt=doCalc();
			amt = (amt != 0) ? amt : Number(amount);
			return usd(amt);
		}
		public function reCalc():void
		{
			var amt:Number;
			var _rt:Number = _invoiceItem.Rate;
			var _qty:int = _invoiceItem.Qty;
			
			amt = _rt * _qty;
			_invoiceItem.Amount = amt;
			amount = String(amt);
		}
		private function doCalc():Number
		{
			var amt:Number;
			var _rt:Number = _invoiceItem.Rate;
			var _qty:int = _invoiceItem.Qty;
			
			amt = 0;
			if(_rt != 0)
			{
				amt = _rt * _qty;
			}
			amount = String(amt);
			return amt;
		}
		public function get ItemAmount():String
		{
			var i:int, len:int;
			var amt:String, total:Number;
			total = 0;
			if(_chargeTypeID == perMemberType && _memberType != null)
			{
				len = _memberType.length;
				for(i=0; i<len; i++)
				{
					if(_memberTypeID == _memberType[i].MemberTypeID)
					{
						amt = _memberType[i].Amount;
						total += Number(amt);
						break;
					}
				}
			}
			else
			{
					total = Number(amount);
			}
			return usd(total);
		}
		public function get ItemInvoiceAmt():String
		{
			reCalc();
			return usd(_invoiceItem.Amount);
		}
		public function get InvoiceAmtNum():Number
		{
			return _invoiceItem.Amount;
		}
		public function set ItemTaxPercent(s:String):void
		{
			_taxPercent = s;
			_invoiceItem.Tax = Number(s);
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		public function get ItemTaxPercent():String
		{
			return _taxPercent;
		}
		public function set ItemInvoiceTax(n:Number):void
		{
			_invoiceItem.Tax = n;
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		public function get ItemInvoiceTax():Number
		{
			return _invoiceItem.Tax;
		}
		public function get ItemTaxAmt():Number
		{
			var tax:Number = 0;
			try {
				tax = _invoiceItem.Tax;
			} catch(e:Error) {
				tax = 0;
			}
			return tax;
		}
	    public function set ItemMinTax(s:String):void
	    {
	    	_taxMin = s;
	    	this.dispatchEvent(new Event(Event.CHANGE));
	    }
	    public function get ItemMinTax():String
	    {
	    	return usd(Number(_taxMin));
	    }
	    public function set ItemMaxTax(s:String):void
	    {
	    	_taxMax = s;
	    	this.dispatchEvent(new Event(Event.CHANGE));
	    }
	    public function get ItemMaxTax():String
	    {
	    	return usd(Number(_taxMax));
	    }
	    public function set ItemIsActive(s:String):void
	    {
	    	_isActive = s;
	    }
	    public function get ItemIsActive():String
	    {
	    	return _isActive;
	    }
	    public function set ItemChargeID(i:int):void
	    {
	    	_chargeItemID = i;
	    }
	    public function get ItemChargeID():int
	    {
	    	return _chargeItemID;
	    }
	    public function set ChargeItemID(i:int):void
	    {
	    	_chargeItemID = i;
	    }
	    public function get ChargeItemID():int
	    {
	    	return _chargeItemID;
	    }
	    public function set ItemCharge(s:String):void
	    {
	    	_chargeItem = s;
	    }
	    public function get ItemCharge():String
	    {
	    	return _chargeItem;
	    }
	    public function set ItemTypeID(i:int):void
	    {
	    	_chargeTypeID = i;
	    }
	    public function get ItemTypeID():int
	    {
	    	return _chargeTypeID;
	    }
	    public function set ItemClubID(i:int):void
	    {
	    	_clubID = i;
	    }
	    public function get ItemClubID():int
	    {
	    	return _clubID;
	    }
	    public function set ItemIsSelected(b:Boolean):void
	    {
	    	_isSelected = b;
	    }
	    public function get ItemIsSelected():Boolean
	    {
	    	return _isSelected;
	    }
	    public function set ItemQty(i:int):void
	    {
	    	_invoiceItem.Qty = i;
	    	this.dispatchEvent(new Event(Event.CHANGE));
	    }
	    public function get ItemQty():int
	    {
	    	return _invoiceItem.Qty;
	    }
	    public function set ItemIndex(i:int):void
	    {
	    	_index = i;
	    }
	    public function get ItemIndex():int
	    {
	    	return _index;
	    }
	    public function set ItemChargeType(s:String):void
	    {
	    	_chargeType = s;
	    }
	    public function get ItemChargeType():String
	    {
	   		return _chargeType;
	   	}
	   	public function set ItemDateTo(d:Date):void
	   	{
	   		_dateTo = d;
	   	}
	   	public function get ItemDateTo():Date
	   	{
	   		return _dateTo;
	   	}
	   	public function set ItemDateFrom(d:Date):void
	   	{
	   		_dateFrom = d;
	   	}
	   	public function get ItemDateFrom():Date
	   	{
	   		return _dateFrom;
	   	}
	   	public function set ItemDateRngID(i:int):void
	   	{
	   		_dateRngID = i;
	   	}
	   	public function get ItemDateRngID():int
	   	{
	   		return _dateRngID;
	   	}
	   	public function set ItemGLaccount(s:String):void
	   	{
	   		_invoiceItem.GL_Account = s;
	   	}
	   	public function  get ItemGLaccount():String
	   	{
	   		return _invoiceItem.GL_Account;
	   	}
	   	public function set ItemGLaccountID(i:int):void
	   	{
	   		_invoiceItem.GL_AccountID = i;
	   	}
	   	public function get ItemGLaccountID():int
	   	{
	   		return _invoiceItem.GL_AccountID;
	   	}
	   	public function set ItemInvoiceID(id:int):void
	   	{
	   		_invoiceItem.InvoiceID = id;
	   	}
	   	public function get ItemInvoiceID():int
	   	{
	   		return _invoiceItem.InvoiceID;
	   	}
	   	public function get ItemInvoice():InvoiceItem
	   	{
	   		return _invoiceItem;
	   	}
	   	public function ItemDup(ci:ChargeItem):void
	   	{
	   		amount = ci.ItemAmount
	   		_taxPercent = ci.ItemTaxPercent;
	   		_taxMin = ci.ItemMinTax;
	   		_taxMax = ci.ItemMaxTax;
	   		_isActive = ci.ItemIsActive;
	   		_chargeItemID = ci.ItemChargeID;
	   		_chargeTypeID = ci.ItemTypeID;
	   		_chargeType = ci.ItemChargeType;
	   		_mealcodeID	= ci.MealCodeID;
	   		_clubID = ci.ItemClubID;
	   		_dateTo = ci.ItemDateTo;
	   		_dateFrom = ci.ItemDateFrom;
	   		_dateRngID = ci.ItemDateRngID;
	   		_isSelected = ci.ItemIsSelected;
	   		_isActive = ci.ItemIsActive;
	   	}
	   	private function remoteError(e:FaultEvent):void
		{
			Alert.show(e.fault.faultString + _chargeItem);
		}
		private function memberTypeCFC(e:ResultEvent):void
		{
			var rmtMsg:RemotingMessage;
    		var msgOp:String;
    		var ac:ArrayCollection;
    		var i:int, len:int;
    		var mt:MemberType;
    		
    		rmtMsg = e.token.message as RemotingMessage;
    		msgOp = rmtMsg.operation;
    		if(msgOp == "Lookup")
    		{
    			ac = e.result as ArrayCollection;
    			len = ac.length;
    			_memberType = new ArrayCollection;
    			
    			for(i=0; i<len; i++)
    			{
    				mt = new MemberType(ac[i]);
    				_memberType.addItem(mt);
    			}
    		}
    		if(msgOp == "SaveQ")	// Let caller know
    		{
    			_pending = false;
    			if(_callBack != null)
    			{
    				_callBack();		// Causes dgRefresh - chargeItemCFC.Lookup
    			}
    		}
		}
		private function memberRecurringCFC(e:ResultEvent):void
		{
			if(_callBack != null)
			{
				_callBack();		// Refresh list
			}
		}
		private function memberSelectedCFC(e:ResultEvent):void
		{
			if(_callBack != null)
			{
				_callBack();		// Refresh list
			}
		}
		
	}
}