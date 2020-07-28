package com.infusion.attendanceoffline.commands
{
	import com.adobe.cairngorm.control.FrontController;
	import com.infusion.attendanceoffline.events.GetAllMeetingsEvent;
	import com.infusion.attendanceoffline.events.GetMealCodesEvent;
	import com.infusion.attendanceoffline.events.LoginEvent;	

	public class Controller extends FrontController
	{
		public function Controller()
		{
			initialiseCommands();
		}
		
		public function initialiseCommands() : void
		{
			//addCommand( MessageEvent.GET_MESSAGE, GetMessageCommand );
			addCommand(LoginEvent.LOGIN, LoginCommand);
			addCommand(GetAllMeetingsEvent.GET_ALL_MEETINGS, GetAllMeetingsCommand);
			addCommand(GetMealCodesEvent.MEAL_CODES, GetMealCodesCommand);
		}
	}
	
}