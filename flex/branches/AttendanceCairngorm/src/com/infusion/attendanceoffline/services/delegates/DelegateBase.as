package com.agilent.smartoptics.systemmaster.admingui.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.IResponder;
	
	public class DelegateBase
	{
		
		protected var _responder:IResponder;
		protected var _service:Object;		
		
		public function DelegateBase(aResponder:IResponder, aServiceName:String)
		{
			this._responder = aResponder;
			this._service = ServiceLocator.getInstance().getRemoteObject(aServiceName);
		}
	}
}