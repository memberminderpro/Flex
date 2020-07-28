package com.infusion.attendanceoffline.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.attendanceoffline.events.GetMealCodesEvent;
	import com.infusion.attendanceoffline.model.dtos.MealCodeVO;
	import com.infusion.attendanceoffline.services.delegates.ClubMeetingDelegate;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.*;
	
	public class GetMealCodesCommand extends CommandBase 
	{
	  	public function GetMealCodesCommand(){	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var clubID:int = (event as GetMealCodesEvent).clubID; 
			
			var delegate:ClubMeetingDelegate = new ClubMeetingDelegate(this);
			trace("GetMealCodes from server");
			delegate.getMealCodesForClub(clubID);
		}
	
		override public function result( event : Object ):void {				
			//store the resulting data in the model locator 
			_model.mealCodes = event.result as ArrayCollection; 
			trace("Got Meal Codes from server: "+_model.mealCodes);
			for(var i:int=0; i < _model.mealCodes.length; i++) {
				var o:MealCodeVO = new MealCodeVO(_model.mealCodes.getItemAt(i));
				trace((o.MealCode)); 
			}
		}
	
	}

}