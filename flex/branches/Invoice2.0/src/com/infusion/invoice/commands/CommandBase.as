package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.model.AppModelLocator;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;

	public class CommandBase implements IResponder, ICommand
	{		
		/**
		 * Command Base Model Reference
		 */
		protected static const _model:AppModelLocator = AppModelLocator.getInstance();

		public function CommandBase()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
		}
		
		//Must override this function in your concrete command
		public function result(data:Object):void
		{
		}
		
		public function fault(info:Object):void
		{
			trace("ERROR: "+this+", "+info.toString());
			
		}
	}
}