package accounts
{
		// Use to add new Register Items 
	[Bindable]
	[RemoteClass(alias="RegisterItem")]
	public class RegisterItem
	{
		//In case we get something with no dFlag and RefNum
		public static function castToRegisterItem(o:Object):RegisterItem {
			var re:RegisterItem = new RegisterItem();
			re.RegisterItemID = o.RegisterItemID;
			re.RegisterID = o.RegisterID;
			re.AccountCode = o.AccountCode;
			re.EntityID = o.EntityID;
			re.GL_Account = o.GL_Account;
			re.GL_AccountID = o.GL_AccountID;
			re.GL_AccountTypeID = o.GL_AccountTypeID;
			re.Memo = o.Memo;
			re.Description = o.Description;
			re.Debit = o.Debit;
			re.Credit = o.Credit;
			re.dFlag = o.dFlag;
			return re;
		}
		
		public var RegisterItemID:int;
		public var RegisterID:int; //Parent Register fk
		public var AccountCode:int = 0;
		public var EntityID:int = 0; // also member's ID
		public var GL_Account:String = "";  
  		public var GL_AccountID:int = 0;
  		public var GL_AccountTypeID:int = 0;
  		public var Memo:String = ""; //also member's name or Comment
  		public var Description:String = "";
  		public var Debit:Number = 0.00;
 		public var Credit:Number = 0.00;
 		public var RefNum:String = "";
 		public var dFlag:Boolean = false;				//New -- flag deleted items so SAVEQ does the delete, not an immediate delete

 		
 		public function toString():String {
 			return "RI: memo="+Memo+", descr="+Description+", debit="+Debit+", credit="+Credit+", GL_Account: "+GL_Account+", GL_AccountID: "+GL_AccountID+", EntityID: "+EntityID+", D?"+dFlag;
 			
 		}
	}
}