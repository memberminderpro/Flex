package com.infusion.invoice.views.components.chargeItemsPanel
{
	import mx.containers.HBox;

	public class DateBarComponent extends HBox
	{
		[Bindable] public var fromdate:Date;
		[Bindable] public var todate:Date;
		[Bindable] public var rID:int;
		public function DateBarComponent()
		{
			super();
		}
		
		/* to initialize the state if needed
		rID = SCI.ItemDateRngID;
			
			//Loop to match on DateID=rID
			var dateId:int = 0;
			dateLen = acDate.length;
			for(dateId; dateId < dateLen; dateId++) {
				if(acDate[dateId].DateID == rID) {
					break;
				}
			}
			dateId = (dateId < dateLen)? dateId: 0;
				
			if(rID > 0) 		// not custom
			{
				fromdate = new Date(acDate[dateId].StartPeriod);
				todate = new Date(acDate[dateId].EndPeriod);
			}
			else
			{
				if(SCI.ItemDateFrom != null)
				{
					fromdate = SCI.ItemDateFrom;
				}
				else
				{
					fromdate = new Date();		// Default
				}
				if(SCI.ItemDateTo != null)
				{
					todate = SCI.ItemDateTo;
				}
				else
				{
					todate = new Date();
				}
			}
			
			if(startDate != null)
			{
				startDate.selectedDate = fromdate;
			}
			if(endDate != null)
			{
				endDate.selectedDate = todate;
			}
			if(sdrMenu != null)
			{
				sdrMenu.selectedIndex = dateId;
			}
			}
		
		// More fun with Dates	
		public function get fromDate():Date
		{
			return (startDate != null && startDate.selectedDate != null) ? startDate.selectedDate : new Date();
		}
		public function get toDate():Date
		{
			return (endDate != null && endDate.selectedDate != null) ? endDate.selectedDate : new Date();
		}
		public function get DateID():int
		{
			return (sdrMenu != null) ? sdrMenu.selectedItem.DateID : 0;
		}
		private function customDate(e:Event):void
		{
			sdrMenu.selectedIndex = 0;
		}
		private function selDateMenu(e:Event):void
		{
			var idx:int;
			var sDate:String;
			var eDate:String;
					
			sDate = e.currentTarget.selectedItem.StartPeriod;
			eDate = e.currentTarget.selectedItem.EndPeriod;
			
			startDate.selectedDate = (sDate != "") ? new Date(sDate) : new Date();
			endDate.selectedDate = (eDate != "") ? new Date(eDate) : new Date();
		}
*/
		
	}
}