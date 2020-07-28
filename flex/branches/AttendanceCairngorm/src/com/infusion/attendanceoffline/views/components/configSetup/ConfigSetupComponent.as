package com.infusion.attendanceoffline.views.components.configSetup
{
	import com.infusion.attendanceoffline.model.dtos.AttdConfig;
	
	import mx.containers.Panel;
	
	public class ConfigSetupComponent extends Panel
	{
		[Bindable] public var boundAttendanceConfig:AttdConfig = new AttdConfig();
		
		public function ConfigSetupComponent()
		{
		}

	}
}