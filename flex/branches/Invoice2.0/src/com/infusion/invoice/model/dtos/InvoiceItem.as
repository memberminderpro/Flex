package com.infusion.invoice.model.dtos
{
	[Bindable]
	[RemoteClass(alias="InvoiceItem")]
	public class InvoiceItem
	{
		public var InvoiceItemID:int;   
  		public var InvoiceID:int;
  		public var Description:String;
		public var GL_AccountID:int;
		public var GL_Account:String;
  		public var Qty:int;
		public var Rate:Number;
		public var Amount:Number;
		public var Tax:Number;
		public var ChargeItemID:int;
	}
}