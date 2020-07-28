package com.infusion.attendanceoffline.views.components
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import mx.controls.Button;
	
	public class NetworkStatusIndicator extends Button
	{
		private var networked:Boolean = false;
		private var timer:Timer;
		private var checkNetworkInterval:int = 5*60*1000; //5 mins in milliseconds 
		private var headRequest:URLRequest = new URLRequest();
		private var connectTest:URLLoader = null;
		
		public function NetworkStatusIndicator()
		{
		}
		
		/**  Internet Connectivity **/
		private function initNetworking():void {
 			NativeApplication.nativeApplication.addEventListener(Event.NETWORK_CHANGE, checkNetworkConnection);
 			timer = new Timer(checkNetworkInterval); //5 mins default
            timer.addEventListener("networkchecktimer", checkNetworkConnection);
            timer.start();
            
            //checkNetworkConnection();
		}
		
		/**
		 * Will attempt open a connection to the dacdb server
		 */
		private function checkNetworkConnection(event:Event=null):void{

		}


//		private function setNetworked(connected:Boolean):void {
//			networked = connected;
//			if(connected) {
// 				currentState = "online";
// 			} else {
// 				currentState = "offline";
// 			}
// 			
// 			//trace(networked);
//		}

	}
}