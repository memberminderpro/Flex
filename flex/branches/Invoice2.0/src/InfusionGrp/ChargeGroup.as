package InfusionGrp
{
	/*
		This class groups members and makes quanity request to Database
		See Invoice line 1018  addChargeGrp
	*/
	public class ChargeGroup
	{
		import mx.controls.Alert;
		import mx.events.*;
		import mx.messaging.messages.RemotingMessage;
		import mx.rpc.events.FaultEvent;
		import mx.rpc.events.ResultEvent;
		import mx.rpc.remoting.mxml.RemoteObject;
		import mx.controls.DataGrid;
		
		private var _chargeItemQty:RemoteObject;
		private var arMC:Array;
		private var _chargeID:int;
		private var _ci:ChargeItem;
		private var _dg:DataGrid;
		
		public function ChargeGroup(ci:ChargeItem)
		{
			// Set up Remote Object for quanity
        	_chargeItemQty = new RemoteObject;
        	_chargeItemQty.destination="ColdFusion";
        	_chargeItemQty.addEventListener(FaultEvent.FAULT,remoteError);
        	_chargeItemQty.addEventListener(ResultEvent.RESULT, itemQtyCFC);
        	arMC = new Array();
        	_ci = new ChargeItem(null);
        	_ci.ItemDup(ci);
		}
		public function set dsn(_dsn:String):void
		{
			_chargeItemQty.source = _dsn + ".CFC.ChargeItemDAO";
		}
		public function set endPoint(ep:String):void
		{
			_chargeItemQty.endpoint = ep;
		}
		public function set dataGrid(dg:DataGrid):void
		{
			_dg = dg;
		}
		public function addGroupMember(mc:MemberClass):void
		{
			arMC.push(mc);			// Save Member Reference
		}
		public function sendGroup(type:int):void
		{
			var uid:String;
			var i:int, len:int;
			var _dateTo:Date, _dateFrom:Date;
			len = arMC.length;
			uid = (len > 1) ? arMC[0].UserID + "," : arMC[0].UserID;
			_chargeID = type;		// Save reference
			_dateTo = _ci.ItemDateTo;
			_dateFrom = _ci.ItemDateFrom;
			
			for(i=1; i<len; i++)
			{
				uid += (i == len-1) ? arMC[i].UserID : arMC[i].UserID + ",";
			}
			if(type == 3)	//Attended
			{
				_chargeItemQty.CountMeetingsAttended(uid, 0, _dateTo, _dateFrom);
			}
			if(type == 4)	// Missed
			{
				_chargeItemQty.CountMeetingsMissed(uid, 0, _dateTo, _dateFrom);
			}
		}
		private function itemQtyCFC(e:ResultEvent):void
		{
			var i:int, j:int, len:int, rlen:int;
			var uid:int, _cnt:int;
			var ciNew:ChargeItem;
			
			len = arMC.length;
			rlen = e.result.length;
			
			for(i=0; i<rlen; i++)		//Result length - could be 0
			{
				uid = e.result[i].UserID;
				_cnt = e.result[i].Cnt;
				for(j=0; j<len; j++)	//Array length
				{
					if(uid == arMC[j].UserID)
					{
						ciNew = new ChargeItem(null);
						ciNew.ItemDup(_ci);
						ciNew.ItemQty = _cnt;
						arMC[j].addCharge(ciNew);		//Charge with quanity
						arMC.splice(j,1);				//Remove Member from list
						len = arMC.length;
						break;							//Next uid
					}
				}
			}
			/*
				Result from DB may not contain all members - residual members
				are defaulted to 0 quanity
			*/
			for(i=0; i<len; i++)	// Any members not in the result list
			{
				ciNew = new ChargeItem(null);
				ciNew.ItemDup(_ci);
				ciNew.ItemQty = 0;
				arMC[i].addCharge(ciNew);
			}
			_dg.invalidateList();
		}
		private function remoteError(e:FaultEvent):void
		{
			Alert.show(e.fault.faultString);
		}
	}
}