package InfusionGrp
{
	// Use to add new invoices 
	[Bindable]
	[RemoteClass(alias="InvoiceGrp")]
	public class Invoices
	{
		public var InvoiceGrpID:int;   
  		public var InvoiceGrp:String;
		public var AccountID:int;
  		public var ClubID:int;
		public var Period:String;
  		public var InvoiceDate:*;
  		public var DueDate:*;
  		public var IsPosted:String;
  		public var DatePosted:*;
  		public var Amount:int;
  		public var Description:String;
 		public var Message:String;
  		public var IncZeroAmts:String;
  		public var IsProforma:String;
  //		public var Created_By:int;
  //		public var Created_Tmstmp:Date;
  //		public var Modified_By:int;
  //		public var Modified_Tmstmp:Date;
	}
}