package com.infusion.attendanceoffline.views.components.meetings
{
	import com.infusion.attendanceoffline.events.SelectMeetingEvent;
	import com.infusion.attendanceoffline.model.dtos.Meeting;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.containers.VBox;

	public class MeetingListComponent extends VBox
	{
		[Bindable] public var dataMeetingList:ArrayCollection = new ArrayCollection();
		
		public function MeetingListComponent()
		{
			super();
		}
			
		protected function onClick(e:MouseEvent):void {
			var event:SelectMeetingEvent = 
				new SelectMeetingEvent(e.currentTarget.selectedItem as Meeting);
			dispatchEvent(event);
		}
	}
}