package InfusionGrp
{
	[Bindable]
	[RemoteClass(alias="GL_Account")]
	public class Accounts
	{
		public var GL_AccountID:int;
		public var GL_Account:String;
		public var AccountCode:int;
		public var ClubID:int;
		public var EntityID:int;
		public var AccountGrpID:int;
		public var ParentID:int;   
  		public var AccountType:int;
  		public var IsPosting:String;
  		public var IsActive:String;
  		public var IsExport:String;
  		public var ExtAccountCode:String;
  		public var Created_By:int;
  		public var Created_Tmstmp:Date;
 		public var Modified_By:int;
		public var Modified_Tmstmp:Date;
	}
}