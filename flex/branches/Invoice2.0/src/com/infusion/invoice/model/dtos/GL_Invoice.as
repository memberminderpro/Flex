package com.infusion.invoice.model.dtos
{
	[Bindable]
	[RemoteClass(alias="GL_Invoice")]
	public class GL_Invoice
	{
		public var InvoiceID:int;   
  		public var InvoiceGrpID:int;
  		public var UserID:int;
  		public var Amount:String;
		public var Message:String;
		public var InvoiceItem:Array;		//Varible length array
	}
}