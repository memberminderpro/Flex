package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.infusion.invoice.events.GetClubMembersEvent;
	import com.infusion.invoice.services.delegates.GL_AccountDelegate;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.*;
	
	public class GetClubMembersCommand extends CommandBase
	{
	  	public function GetClubMembersCommand()
		{	 
		}
	
		override public function execute( event:CairngormEvent ):void {
			var clubID:int = (event as GetClubMembersEvent).clubID;
			var isOverride:Boolean = (event as GetClubMembersEvent).isOverride;
			var terminationDate:Date = (event as GetClubMembersEvent).terminationDate;
			
			var delegate:GL_AccountDelegate = new GL_AccountDelegate(this);
			delegate.getClubMembers(clubID, isOverride, terminationDate);
		}
	
		override public function result( event : Object ):void {	
			var ac:ArrayCollection = event.result as ArrayCollection;
			if(ac == null || ac.length == 0) {
				trace("Error: Received no Club Members.  Aborting call.");
				return;
			}
			
			_model.membersList = ac;
			trace("Received Club Members: "+_model.membersList.length);
			trace(_model.membersList);
			/* Write them out
			for(var i:int=0; i < _model.chargeItemsList.length; i++) { 
				var o:Object = (_model.chargeItemsList.getItemAt(i));
				//var m:Meeting = new Meeting(_model.invoiceGroupsList.getItemAt(i));
				//trace((m));
			}
			*/		
		}

	}

}