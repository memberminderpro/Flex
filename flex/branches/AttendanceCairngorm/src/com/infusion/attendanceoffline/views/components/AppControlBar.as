package com.infusion.attendanceoffline.views.components
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.infusion.attendanceoffline.events.LoginEvent;
	import com.infusion.attendanceoffline.model.AppModelLocator;
	
	import mx.containers.ApplicationControlBar;

	public class AppControlBar extends ApplicationControlBar
	{
		[Bindable] public var version:String = "V 2.5 07/16/2010";
		public function AppControlBar()
		{
			super();
		}
		public function popupSetup():void {
			
		}
		public function serverSync():void {
			//Login, which will trigger other events: GetAllMeetingsEvent
			var model:AppModelLocator = AppModelLocator.getInstance();
			var event:LoginEvent = new LoginEvent(model.attendanceConfig.userName, model.attendanceConfig.password); 
			//dispatch an event requesting for the message that the server has for us
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
//			var event:GetAllMeetingsEvent = new GetAllMeetingsEvent("mike7710@mikethacker.com", "gofish");
//			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
		public function onClearDataClick():void {
			
		}
		public function popupStatistics():void {
			
		}
		
	}
}