package com.infusion.invoice.model
{
   
   import com.adobe.cairngorm.model.ModelLocator;
   import com.infusion.invoice.model.dtos.ChargeItem;
   import com.infusion.invoice.model.dtos.InvoiceGroup;
   
   import mx.collections.ArrayCollection;
   
   [Bindable]
   public class AppModelLocator implements ModelLocator
   {
      private static var modelLocator : AppModelLocator;
      
      public var appVersion:String = "V 2.0.0 08/06/2010";
      
      //Data Models here
      public var clubID:int = 6128;
      public var districtID:int = 7710; //A.k.a AccountID, a.k.a Region
      public var destination:String = "Rotary";
      public var endPoint:String = "http://76.12.191.145/flex2gateway"

      //[ArrayElementType("InvoiceGroup")]
      public var invoiceGroupsList:ArrayCollection = new ArrayCollection();
      public var selectedInvoiceGroup:InvoiceGroup = new InvoiceGroup();
      
      //[ArrayElementType("ChargeType")]
      public var chargeTypesList:ArrayCollection = new ArrayCollection();
      //[ArrayElementType("ChargeItem")]
      public var chargeItemsList:ArrayCollection = new ArrayCollection();
      public var selectedChargeItem:ChargeItem; //TODO or remote charges?
      
       //[ArrayElementType("Member")]
      public var membersList:ArrayCollection = new ArrayCollection();
      public var memberCharges:ArrayCollection = new ArrayCollection();
      public var memberTypesList:ArrayCollection = new ArrayCollection();
      
      // Utilities
      public var mealCodes:ArrayCollection = new ArrayCollection();
      public var accountsList:XML = new XML();
      public var datePeriodsList:ArrayCollection = new ArrayCollection();
     
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
