package com.infusion.accounting.models
{
   
   import accounts.RegisterDAO;
   
   import com.adobe.cairngorm.model.ModelLocator;
   
   import mx.collections.XMLListCollection;   
   [Bindable]
   public class AppModelLocator implements ModelLocator
   {
      private static var modelLocator : AppModelLocator;
      
      // app models here
      public var membersList:XMLListCollection = new XMLListCollection();
      public var accountsXML:XML = new XML();
      
      public var selectedAccountCode:String = "";
          	
      public var selectedRegister:RegisterDAO;		// Currently Selected Register 
      public var selectedRegisterLine:RegisterDAO;		// Currently Selected Register (Item?)
      public var selectedRegItemType:String = "";
      public var selectedAccountName:String = "";
      public var selectedAccountOwnerName:String = "";
      
      
      
      //TW: 2.5.3 if selectedRegister is locked, disable some buttons and functions
      public var selectedRegisterLineIsLocked:Boolean = false;
      //TW: 2.5.9 If selectedRegister is part of split, don't allow delete
      public var selectedRegisterLineDeletable:Boolean = false;		

      
      public static function getInstance() : AppModelLocator 
      {
      	if ( modelLocator == null )
      	{
      		modelLocator = new AppModelLocator();
      	}
      		
      	return modelLocator;
      }
      
      public function AppModelLocator() 
      {	
         if ( modelLocator != null )
         {
         	throw new Error( "Only one ModelLocator instance should be instantiated" );	
         }
      }
   
   }

}
