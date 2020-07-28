package com.infusion.invoice.views.components.chargeItemsPanel
{
	import InfusionGrp.ChargeItemType;
	
	import com.infusion.invoice.events.CreateChargeItemEvent;
	import com.infusion.invoice.events.DeleteChargeItemEvent;
	import com.infusion.invoice.events.UpdateChargeItemEvent;
	import com.infusion.invoice.model.dtos.*;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;


	public class BasicChargePanelComponent extends VBox
	{
		public function BasicChargePanelComponent()
		{
			super();
		}

		//TW:cairngorm
		[Bindable] public var selectedChargeItem:ChargeItem = new ChargeItem(null);
		[Bindable] public var staticDataChargeTypes:ArrayCollection = new ArrayCollection();
		[Bindable] public var staticDataMealCodes:ArrayCollection = new ArrayCollection();

		[Bindable]
		public var acMemRecurring:ArrayCollection = new ArrayCollection();
		[Bindable]
		public var acMemSelected:ArrayCollection = new ArrayCollection();
		private var popAcct:popUpAccounts;


		[Bindable]
		public var acItemMemberType:ArrayCollection = new ArrayCollection();
		//TODO decide this or RemoteCharges 
		public var _ci:ChargeItem;
		private var _isNew:Boolean = true;
		
		private function initPanel():void
		{
			//init combo box of types - respect ordering
			//chargeTypeID, ChargeType, IsActive, TypeID, PositionSort
			staticDataChargeTypes = new ArrayCollection(); //TODO TW:cairngorm inv.acChargeType;
			var defaultCI:ChargeType = new ChargeType();
			defaultCI.ChargeTypeID = 0;
			defaultCI.ChargeType = "** Select a Charge Type **";
			defaultCI.IsActive = true;
			defaultCI.TypeID = 0;
			defaultCI.PositionSort = -1;
			staticDataChargeTypes.addItemAt(defaultCI, 0);
			
			//filter on IsActive and sort on PositionSort
			staticDataChargeTypes.filterFunction = filterChargeTypes;
			var sortPosition:Sort = new Sort();
			var sortByPos:SortField = new SortField("PositionSort",false,false,true);
			sortPosition.fields=[sortByPos];
			staticDataChargeTypes.sort=sortPosition;
            staticDataChargeTypes.refresh();
				
		}
		
		public function filterChargeTypes(item:Object):Boolean{
			return item.IsActive;	
		}
		
		private function initMeals():void
		{
			//TODO why?
			selectedChargeItem.ItemChargeID = staticDataMealCodes[0].MealCodeID;	
		}
		/*
			Set Display Mode
		*/
		public function setDisplay(display:int):void
		{
			var children:Array;
			var i:int, len:int;
			
			switch(display)
			{
				case 0: 
					currentState = "Base1"		// On New
					break;
				case 1:
					currentState = ""; //on Cancel or delete
					break;
				case 2:
					currentState = "memberType";
					break;
				case 4:
					currentState = "memberReoccur";
					break;
				case 8:
					currentState = "datebar";
					break;
				case 10:
					currentState = "mtgAttended";
					break;
				case 25:
					currentState = "mealCode";
					break;
				case 33:
					currentState = "memberSelected";
					break;
				default:
					currentState = "Base1";
					Alert.show("Could not find display for "+display);
					break;
			}
  		} 		

		/*
		 	itemClick event from charges grid.
		 	Once a Charge is selected from the outside, some extra pushups have to happen
		 	before setting it to bind
		*/  
		public function set ChargeItem(e:Event):void
		{
			var chgType:int;
			var i:int, dateLen:int, id:int;

			
			var args:Object={ClubID:0,ChargeItemID:0};
			var itemDisplayType:int;
			var itemMemberType:ArrayCollection;
			var ci:ChargeItem;
			var SCI:ChargeItem;

			// Set up display
			setDisplay(itemDisplayType);
			
			// setup dropdown and table data if needed
			var ctIdx:int = getRealChargeIndex(id);
			
    		switch(id)
    		{
   				case perMemberType:
    				acItemMemberType = itemMemberType;
    				break;
    			case perMeetingAttendedMemberType:
    			case perMeetingMissedMemberType:
    				acItemMemberType = itemMemberType
    				if(dgMemType1 != null)
    				{
    					dgMemType1.validateNow();
    				}
    				break;
    			case perMemberRecurring:
    				args.ChargeItemID = ci.ChargeItemID;
    				memberRecurring.Lookup(args);
    				break;
    			case perMemberSelected:
    				args.ChargeItemID = ci.ChargeItemID;
    				memberSelected.Lookup(args);
    				break;
    			case perMealCode:
    				cbMealCode.selectedIndex = setMealCode();
    				break;

   				default:
   				    //Alert.show("No extra data needed for "+id);
   					//currentState = "";
    				//cbChargeType.selectedIndex = 0;
    				break;
			}			
		}
		
		private function setMealCode():int
		{
			for(var i:int=0; i<staticDataMealCodes.length; i++)
			{
				if(staticDataMealCodes[i].MealCodeID == selectedChargeItem.MealCodeID)
				{
					break;
				}
			}
			return i;
		}
		
		/** Maps the ChargeTypeID to the position in the combo box
		 * */
		private function getRealChargeIndex(id:int):int
		{
			var listIdx:int = 0;
			var len:int;
			var realIdx:int = 0;
			len = staticDataChargeTypes.length;
			for(listIdx=0; listIdx<len; listIdx++)
			{
				var listid:int = staticDataChargeTypes[listIdx].ChargeTypeID;
				if(listid == id)
				{
					realIdx = listIdx;
					break;
				}
			}
			return realIdx;
		}
		
		  /*
        	Here from ComboBox Change Event
        	Charge Item Tab id=cbChargeType
        */        
		private function CTchange(e:Event):void
		{
			var idx:int, mode:int;
			var args:Object = {ClubID:0, ChargeItemID:0};
			
			args.ClubID = inv.clubID;
			//var chargeType:ChargeItemType = e.currentTarget.selectedItem as ChargeItemType;
			idx = e.currentTarget.selectedItem.ChargeTypeID;
			mode = e.currentTarget.selectedItem.TypeID;
			
			setDisplay(mode);
			selectedChargeItem.ItemTypeID = idx;
			
			switch(idx)
			{
				case InvConstants.perMemberType:
					SelChargeItem.ItemMemberType = inv.createTypeArray();
					acItemMemberType = SelChargeItem.ItemMemberType;
					break;
				case InvConstants.perMeetingAttended:
					SelChargeItem.ItemTypeID = perMeetingAttended;
					setMeeting();
					break;
				case InvConstants.perMeetingMissed:
					SelChargeItem.ItemTypeID = perMeetingMissed;
					setMeeting();
					break;
				case InvConstants.perMemberRecurring:
					SelChargeItem.ItemTypeID = perMemberRecurring;
					memberRecurring.Lookup(args);
					break;
				case InvConstants.perMemberSelected:
					SelChargeItem.ItemTypeID = perMemberSelected;
					memberSelected.Lookup(args);
					break;
				case InvConstants.perMakeUp:
					SelChargeItem.ItemTypeID = perMakeUp;
					setMeeting();
					break;
				case InvConstants.perMeetingAttendedMemberType:		// per member type
					SelChargeItem.ItemTypeID = perMeetingAttendedMemberType;
					SelChargeItem.ItemMemberType = inv.createTypeArray();
					acItemMemberType = SelChargeItem.ItemMemberType;
					break;
				case InvConstants.perMeetingMissedMemberType:		// per member type
					SelChargeItem.ItemTypeID = perMeetingMissedMemberType;
					SelChargeItem.ItemMemberType = inv.createTypeArray();
					acItemMemberType = SelChargeItem.ItemMemberType;
					break;
				case InvConstants.perMealCode:
					SelChargeItem.ItemTypeID = perMealCode;
					break;
				default:
					break;
			}
			function setMeeting():void
			{
				startDate.selectedDate = new Date();
				endDate.selectedDate = new Date();
			}
			inv._SelChargeItem = SelChargeItem;
			inv.btnSaveCharge.enabled = chkValues();
			
		}

		/*
			071808 - Add Member Recurring functions
			Process results from ChargeMemberRecurringDAO
		*/
		public function memberRecurringHandler(e:ResultEvent):void
		{
    		var i:int, len:int, id:int;
    		var ac:ArrayCollection;
    		var r:Recurring;
    		var sendData:String;
    		var sendArray:Array;
    		
    		acMemRecurring = new ArrayCollection();
    		ac = e.result as ArrayCollection;
    		len = ac.length;
    		for(i=0; i<len; i++)
    		{
    			r = new Recurring(ac[i]);
    			acMemRecurring.addItem(r);
    		}
    		dgMemReoccur.dataProvider = acMemRecurring;
		}
		/*
			Add Per Member Selected functions
			Process results from ChargeMemberSelectedDAO
		*/
		public function memberSelectedHandler(e:ResultEvent):void
		{
    		var i:int, len:int, id:int;
    		var ac:ArrayCollection;
    		var sm:SelectedMember;
    		
    		acMemSelected = new ArrayCollection();
    		ac = e.result as ArrayCollection;
    		len = ac.length;
    		for(i=0; i<len; i++)
    		{
    			sm = new SelectedMember(ac[i]);
    			//Alert.show(""+sm);
    			acMemSelected.addItem(sm);
    		}
    		dgMemSelected.dataProvider = acMemSelected;
		}
		
		private function remoteError(e:FaultEvent):void
 		{
 			Alert.show(e.fault.faultString, "Server Error");	
 		}
		private function popAcctList():void
		{
			popAcct = popUpAccounts(PopUpManager.createPopUp(this, popUpAccounts, true));
            popAcct.boundAccountsList = this.parentApplication.xmlAcctList;
            popAcct.callBack = this.parentApplication.saveAcct;
		}
		
		//we could not do this as a state until subclassing
		// is complete, so for now, do here
		/* TW this will be handled in mxml
		public function chargeTypeReadOnly(b:Boolean):void {
				//make it read-only by not showing combo box
				// but showing a label and vice versa
				cbChargeType.visible = !b;
				chargeTypeLabel.visible = b;
		}
		
			/*
			Here from button click btnSaveCharge 
			Charge Item tab.
		*/
		/* TODO move here from Invoice **
		private function saveChgItem():void
		{
			var today:Date = new Date();
			var i:int, len:int;
			var meal:int = 0;
			
			//if(!bUpdate)
			//{
				_ci = new RemoteCharges();
			//}
			//Alert.show("Charge type?! "+ chargeGrid.cbChargeType.selectedItem.ChargeTypeID);
			if(this.cbMealCode != null && this.cbChargeType != null 
				&& this.cbChargeType.selectedItem.ChargeTypeID == perMealCode)
			{
				meal = this.cbMealCode.selectedItem.MealCodeID;
			} else {
				meal = null;
			}
			_ci.ChargeItem = this.chgDescript.text;
			_ci.ChargeTypeID = this.cbChargeType.selectedItem.ChargeTypeID;				
//TODO			_ci.ClubID = clubID;
			_ci.IsActive = this.cbChargeType.selectedItem.IsActive;
			_ci.Amount = this.chargeAmt.text;
			_ci.DateRangeID = this.DateID;
			_ci.DateFrom = this.fromDate;
			_ci.DateTo = this.toDate;
			_ci.MealCodeID = meal;
			_ci.TaxPercent = this.chgPercent.text;
			_ci.TaxMin = this.chgMin.text;
			_ci.TaxMax = this.chgMax.text;
//TODO			_ci.GL_Account = acctName;
//TODO			_ci.GL_AccountID = acctID;
			 
			if(!bUpdate)
			{
				chargeItemCFC.Create(_ci); //TODO move out
			}
			else
			{
				chargeItemCFC.Update(_ci); //TODO move out
			}
		}
		*/
		
				/*
			Here from button click btnSaveCharge 
			Charge Item tab.
		*/
		private function saveChgItem():void
		{
			var today:Date = new Date();
			var i:int, len:int;
			var meal:int = 0;
			
			//Alert.show("Charge type?! "+ chargeGrid.cbChargeType.selectedItem.ChargeTypeID);
			if(cbMealCode != null && cbChargeType != null 
				&& cbChargeType.selectedItem.ChargeTypeID == perMealCode)
			{
				meal = chargePanel.cbMealCode.selectedItem.MealCodeID;
			} else {
				meal = -200;
			}
			/*
			_ci.ChargeItem = chargePanel.chgDescript.text;
			_ci.ChargeTypeID = chargePanel.cbChargeType.selectedItem.ChargeTypeID;				
			_ci.ClubID = clubID;
			_ci.IsActive = chargePanel.cbChargeType.selectedItem.IsActive;
			_ci.Amount = chargePanel.chargeAmt.text;
			_ci.DateRangeID = chargePanel.DateID;
			_ci.DateFrom = chargePanel.fromDate;
			_ci.DateTo = chargePanel.toDate;
			_ci.MealCodeID = meal;
			_ci.TaxPercent = chargePanel.chgPercent.text;
			_ci.TaxMin = chargePanel.chgMin.text;
			_ci.TaxMax = chargePanel.chgMax.text;
			_ci.GL_Account = acctName;
			_ci.GL_AccountID = acctID;
			 */
			if(!bUpdate)
			{				
				//chargeItemCFC.Create(_ci);
				//TW:cairngorm chargeItemCFC.create(chargeItem);
				var createChargeItemEvent:CreateChargeItemEvent
					= new CreateChargeItemEvent(_ci);
				CairngormEventDispatcher.getInstance().dispatchEvent(createChargeItemEvent);
				
			}
			else
			{
				//chargeItemCFC.Update(_ci);
				//TW:cairngorm chargeItemCFC.Update(chargeItem);
				var updateChargeItemEvent:UpdateChargeItemEvent
					= new UpdateChargeItemEvent(_ci);
				CairngormEventDispatcher.getInstance().dispatchEvent(updateChargeItemEvent);
				
			}
			chargePanel.cbChargeType.enabled = false;
			bUpdate = true;

		}
		/*
			Here from btnDeleteCharge
		*/
		private function deleteCharge():void
		{
			var popDelete:popUpPost = popUpPost(PopUpManager.createPopUp(this, popUpPost, true));
			popDelete.title = "Confirm Delete";
			popDelete.messageText.text = "Delete this item?";
            popDelete.postBack = deleteChargeYes;
		}
		
   		//Called if popup in deleteCharge shows user said "Yes"
   		private function deleteChargeYes():void {

			_ci = new ChargeItem(null);
			//TODO _ci.ChargeItemID = _SelChargeItem.ItemChargeID;
			//TODO _ci.ChargeItem = _SelChargeItem.ItemDescription;
			//TW:cairngorm chargeItemCFC.delete(chargeItem);
			var deleteChargeItemEvent:DeleteChargeItemEvent
				= new DeleteChargeItemEvent(_ci);
			CairngormEventDispatcher.getInstance().dispatchEvent(deleteChargeItemEvent);
				
			selectedChargeItem = new ChargeItem(null);
   		}

	}
}