package com.infusion.attendanceoffline.views
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.infusion.attendanceoffline.events.LoginEvent;
	import com.infusion.attendanceoffline.model.AppModelLocator;
	
	import mx.collections.ArrayCollection;
	import mx.containers.VBox;
	import mx.controls.Alert;

	
	public class MainPanelComponent extends VBox
	{
		[Bindable] public var boundMeetingsList:ArrayCollection = AppModelLocator.getInstance().allMeetings;
		public function MainPanelComponent()
		{
			super();
		}
		
		//TODO any startup commands like opening a database		
		public function onCreateComplete():void {
			
		}
	}
	
}