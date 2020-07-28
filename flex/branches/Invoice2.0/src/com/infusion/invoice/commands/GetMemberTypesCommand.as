package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.GetMemberTypesEvent;
	import com.infusion.invoice.services.delegates.MemberTypeDelegate;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.*;
	
	public class GetMemberTypesCommand extends CommandBase
	{
	  	public function GetMemberTypesCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var clubID:int = (event as GetMemberTypesEvent).clubID;
			
			var delegate:MemberTypeDelegate = new MemberTypeDelegate(this);
			delegate.getMemberTypes(clubID);
		}
	
		override public function result( event : Object ):void {	
			trace("RESULT from "+this);
			var ac:ArrayCollection = event.result as ArrayCollection;
			if(ac == null || ac.length == 0) {
				trace("Error: Received no Member Types.  Aborting call.");
				return;
			}
			
			_model.memberTypesList = ac;
			trace("Received Member Types: "+_model.memberTypesList.length);
			trace(_model.memberTypesList);
			/* Write them out */
			for(var i:int=0; i < _model.memberTypesList.length; i++) { 
				var o:Object = (_model.memberTypesList.getItemAt(i));
				//var m:Meeting = new Meeting(_model.invoiceGroupsList.getItemAt(i));
				//trace(o);
			}
				
		}

	}

}