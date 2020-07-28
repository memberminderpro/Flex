package com.infusion.accounting.commands
{
	import com.adobe.cairngorm.control.FrontController;
	import com.infusion.accounting.event.SelectRegisterLineEvent;
	import com.infusion.accounting.event.ShowDepositDetailsEvent;



	public class Controller extends FrontController
	{
		public function Controller()
		{
			initialiseCommands();
		}
		
		public function initialiseCommands() : void
		{
			//addCommand( MessageEvent.GET_MESSAGE, GetMessageCommand );
			addCommand( ShowDepositDetailsEvent.SHOW_DEPOSIT_DETAILS_EVENT, ShowDepositDetailsCommand );
			addCommand( SelectRegisterLineEvent.SELECT_REGISTER_LINE_EVENT, SelectRegisterLineCommand );
			
		}
	}
	
}