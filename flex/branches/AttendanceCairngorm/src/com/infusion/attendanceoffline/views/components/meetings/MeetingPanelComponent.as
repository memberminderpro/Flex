package com.infusion.attendanceoffline.views.components.meetings
{
	import com.infusion.attendanceoffline.model.dtos.Meeting;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Panel;

	
	public class MeetingPanelComponent extends Panel
	{
		[Bindable] public var selectedMeeting:Meeting = null;
		[Bindable] public var dataMealCodes:ArrayCollection = new ArrayCollection();
		public function MeetingPanelComponent()
		{
			super();
		}
		
		public function localSelectAll():void {
			//TODO fire
		}
		
		public function localClearAll():void {
			//TODO fire
		}
		
		public function localAddGuest():void {
			//TODO fire
		}
		
	}
	
}