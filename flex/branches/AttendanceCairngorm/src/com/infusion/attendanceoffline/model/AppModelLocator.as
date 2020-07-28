package com.infusion.attendanceoffline.model
{
   
   import com.adobe.cairngorm.model.ModelLocator;
   import com.infusion.attendanceoffline.model.dtos.AttdConfig;
   import com.infusion.attendanceoffline.model.dtos.Meeting;
   
   import mx.collections.ArrayCollection;
   
   [Bindable]
   public class AppModelLocator implements com.adobe.cairngorm.model.ModelLocator
   {
      private static var modelLocator : AppModelLocator;
      
      //Data Models here
      [ArrayElementType("Meeting")]
      private var _allMeetings:ArrayCollection = new ArrayCollection();
      
      //Related to Selected Meeting
      public var selectedMeeting:Meeting = null;
      public var membersForMeeting:ArrayCollection = new ArrayCollection();
      
      
      //General Data and configuration
      public var attendanceConfig:AttdConfig = new AttdConfig();
      public var mealCodes:ArrayCollection = new ArrayCollection();
      
      public function set allMeetings(a:ArrayCollection):void {
      	  this._allMeetings = a;
      }
      public function get allMeetings(): ArrayCollection {
      	return this._allMeetings;
      }
      
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
