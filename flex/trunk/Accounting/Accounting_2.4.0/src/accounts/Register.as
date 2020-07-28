package accounts
{
// Use to add new Register Items
	[Bindable]
	[RemoteClass(alias="Register")]
	public class Register
	{
		public var RegisterID:int = 0;   
  		public var RegDate:String;				//* changed MRL
  		public var InvoiceGrpID:int;
		public var RefNum:String;
		public var Memo:String;					//* changed MRL
  		public var Description:String;
  		public var DueDate:String;					
		public var EntityID:int;
  		public var fEdit:int;
		public var AccountCode:int;
  		public var GL_AccountID:int;
  		public var GL_Account:String;
  		public var GL_ParentAccount:String;
  		public var GL_AccountTypeID:int;
// 		public var IsCleared:String;
// 		public var IsProforma:String;
// 		public var IsSplit:String;
		public var bitIsProforma:Boolean;
		public var bitIsSplit:Boolean;
		public var bitIsDeposit:Boolean;
		public var bitIsCheck:Boolean;
		public var bitIsCleared:Boolean;
  		public var RegisterItems:Array;			// used to send RegisterItems Array Back via JSON
  		public var Credit:Number;
  		public var Debit:Number;
//  		public var Balance:Number;			// See if we can do this another way and delete this
		public var fBitLocked:Boolean; //TW 2.5.3

		public function toString():String {
			return "Register: "+RegisterID+", RefNum="+RefNum+", Memo="+Memo+", Description="+Description+", fEdit="+fEdit;
		}
	}

}