package com.infusion.attendanceoffline.views.components.configSetup
{
	import mx.containers.ControlBar;

	public class ConfigSetupButtonBar extends ControlBar
	{
		public function ConfigSetupButtonBar()
		{
			super();
		}
		
		protected function handleSave():void {
			//Dispatch locally, not on Cairngorm for now.
//			var e:CreateMonitorPortEvent = new CreateMonitorPortEvent(new MonitorPort());
//			dispatchEvent(e);
		}
		
		protected function handleCancel():void {
			//Dispatch locally, not on Cairngorm for now.
//			var e:CreateMonitorPortEvent = new CreateMonitorPortEvent(new MonitorPort());
//			dispatchEvent(e);
		}
	}
}