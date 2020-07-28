package com.infusion.invoice.model.dtos
{
	// Use to add new invoices 
	[Bindable]
	[RemoteClass(alias="InvoiceGrp")]
	public class InvoiceGroup
	{
		public var InvoiceGrpID:int;   
  		public var InvoiceGrp:String = "INV-t1";
		public var AccountID:int; //a.k.a. Region or District
  		public var ClubID:int;
		public var Period:String = "";
  		public var InvoiceDate:Date = new Date();
  		public var DueDate:Date = new Date();
  		public var IsPosted:String = "N";
  		public var DatePosted:Date = new Date();
  		public var Amount:int = 0;
  		public var Description:String = "";
 		public var Message:String = "";
  		public var IncZeroAmts:String = "Y";
  		public var IsProforma:String = "N";
  		public var Created_By:int;
  		public var Created_Tmstmp:Date;
  		public var Modified_By:int;
  		public var Modified_Tmstmp:Date;
	}
}