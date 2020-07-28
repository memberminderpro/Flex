package com.infusion.invoice.services.delegates
{	
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.infusion.invoice.model.dtos.ChargeItem;
	
	import mx.messaging.messages.RemotingMessage;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class ChargeItemDelegate
	{
		public function ChargeItemDelegate( responder : IResponder )
		{		
			this.service = ServiceLocator.getInstance().getRemoteObject( "chargeItemCFC" );
			this.responder = responder;
		}
		
		public function getAllChargeItems(clubID:int) : void
		{	
			var objClub:Object = {ClubID:clubID};
			var call : Object = service.Lookup(objClub); 
			call.addResponder( responder );
		}
		
		public function createChargeItem(ci:ChargeItem) : void
		{			
			var call : Object = service.Create(ci); 
			call.addResponder( responder );
		}
		
		public function deleteChargeItem(ci:ChargeItem) : void
		{			
			var call : Object = service.Delete(ci); 
			call.addResponder( responder );
		}
		
		public function UpdateChargeItem(ci:ChargeItem) : void
		{			
			var call : Object = service.Update(ci); 
			call.addResponder( responder );
		}
		
		/*
    		Processes list of Charge Items in Database
    	*
    	private function chargeItemCFCHandler(e:ResultEvent):void
    	{
    		var i:int, len:int, id:int;
    		var ci:ChargeItem;
    		var rmtMsg:RemotingMessage;
    		var msgOp:String;
    		var args:Object = {InvoiceGrpID:invoiceGrpID};
    		
    		rmtMsg = e.token.message as RemotingMessage;
    		msgOp = rmtMsg.operation;
    		if(msgOp == "Lookup")
    		{
    			len = e.result.length;
    			arChargeItem.removeAll();
    		
    			for(i=0; i<len; i++)
    			{
    				ci = new ChargeItem(e.result[i]);
    				ci.ItemChargeType = findChargeType(ci.ItemTypeID);
    				ci.ItemDisplayType = findDisplayType(ci.ItemTypeID);
    				ci.dsn = dsn;
    				ci.endPoint = _endPoint;
    				
    				if(ci.ItemTypeID == perMemberType || 
    					ci.ItemTypeID == perMeetingAttendedMemberType ||
    					ci.ItemTypeID == perMeetingMissedMemberType)
    				{
    					ci.ItemMemberTypeLookup();
    				}
    				arChargeItem.addItem(ci);
    			}
    			if(dgCharge != null)
    			{
    				dgCharge.invalidateList();
    			}
    		}
    		else if(msgOp == "Create" || msgOp == "Update")
    		{
    			
    			
    			if(msgOp == "Create")
    			{
    				//newCharge();
    				_SelChargeItem.ItemChargeID = e.result as int;
    				//TODO Why not on Update too?
    			}

    			if(_SelChargeItem.ItemTypeID == perMemberType || 
    				_SelChargeItem.ItemTypeID == perMeetingAttendedMemberType ||
    				_SelChargeItem.ItemTypeID == perMeetingMissedMemberType)
    			{
    				_SelChargeItem.CallBack = dgRefresh;
    				_SelChargeItem.ItemSaveQ(msgOp);
    			}
    			if(_SelChargeItem.ItemTypeID == perMemberRecurring)
    			{
    				id = e.result as int;
    				_SelChargeItem.CallBack = dgRefresh;
    				if(msgOp == "Create")
    				{
    					_SelChargeItem.RecurringSaveQ(chargePanel.acMemRecurring, id);
    				}
    				if(msgOp == "Update")
    				{
    					_SelChargeItem.RecurringUpdateQ(chargePanel.acMemRecurring, id);
    				}
    			}
    			if(_SelChargeItem.ItemTypeID == perMemberSelected)
    			{
    				id = e.result as int;
    				_SelChargeItem.CallBack = dgRefresh;
    				if(msgOp == "Create")
    				{
    					_SelChargeItem.MemSelectedSaveQ(chargePanel.acMemSelected, id);
    				} else if(msgOp == "Update")
    				{
    					_SelChargeItem.MemSelectedUpdateQ(chargePanel.acMemSelected, id);
    				} else {
    					Alert.show("Unknown message operation:"+msgOp);
    				}
 
    			}
    			chargeItemCFC.Lookup(objClub);
    		}

    		invoiceItemCFC.LookupChargeItems(args);
    	}
    	*/
	
		private var responder : IResponder;
		private var service : Object;
	}

}