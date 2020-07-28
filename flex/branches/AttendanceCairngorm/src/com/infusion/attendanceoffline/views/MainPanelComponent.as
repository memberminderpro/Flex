package com.infusion.attendanceoffline.views
{
	import com.infusion.attendanceoffline.model.AppModelLocator;
	import com.infusion.attendanceoffline.model.dtos.Meeting;
	
	import mx.collections.ArrayCollection;
	import mx.containers.VBox;

	
	public class MainPanelComponent extends VBox
	{
		[Bindable] public var boundMeetingsList:ArrayCollection = AppModelLocator.getInstance().allMeetings;
		[Bindable] public var boundSelectedMeeting:Meeting = AppModelLocator.getInstance().selectedMeeting;
		[Bindable] public var dataMealCodes:ArrayCollection = new ArrayCollection(); 
		public function MainPanelComponent()
		{
			super();
		}
		
		//TODO any startup commands like opening a database		
		public function onCreateComplete():void {
			
		}
	}
	
}