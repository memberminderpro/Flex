package com.infusion.invoice.views.components.memberInvoices
{
	import com.infusion.invoice.model.AppModelLocator;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;

	public class MembersChargesComponent extends HBox
	{
		public var _model:AppModelLocator;
		
		[Bindable] public var isOverride:Boolean = false;
		[Bindable] public var invoiceMembersDate:Date = new Date();
		
		public var localSelectedMembersList:ArrayCollection = new ArrayCollection();
		
		public function MembersChargesComponent()
		{
			super();
		}
		
	}
	
	// DONE: get all members between certain dates
	public function refreshMembers():void
	{
		//data already gathered before call
		var today:Date = new Date();
		
		//Always send on a change
		if(!invoiceMembersDate > today) {
			var getClubMembersEvent:GetClubMembersEvent
				= new GetClubMembersEvent(_model.districtID, isOverride, invoiceMembersDate);
			CairngormEventDispatcher.getInstance().dispatchEvent(getClubMembersEvent);
		}
	}
	
	public function selectAll():void
	{
		// send list of selected UIDs and let the delegate sort it out
		
		
		var addAllMembersEvent:AddAllMemberToInvoiceGroupEvent
			= new AddAllMemberToInvoiceGroupEvent();
		CairngormEventDispatcher.getInstance().dispatchEvent(addAllMembersEvent);
	}
	
	/*
		Here from btnClear - click
		Removes all members
		Clears all Charge Item dgSelCharge
	*/
	public function clearAll(e:Event):void
	{
			
		//TW:cairngormTODO deleteMembers(uidDel, true);
		
	}
	
	/*
		Here from member list - itemClick from dgMember
	*/
	public function addMembers(e:Event):void
	{
		var i:int, len:int;
		var addCount:int;
		var b:Boolean;
		var uidAdd:String="";
		var uidDel:Array = new Array();
		var selInvID:int;
		if(invoiceIsPosted=="Y" 
			|| dgMember == null
			|| !dgMember.enabled) return;
		
		len = dgMember.selectedItems.length;
	
		for (i=0; i<len; i++) {
			b = dgMember.selectedItems[i].IsSelected;
			
			if(!b) {// Inverted value - adding
				uidAdd += dgMember.selectedItems[i].UserID;
				dgMember.selectedItems[i].IsSelected = !b;	//Toggle from previous
				if(i+1 < len) {
					uidAdd += ",";
				}
			}
			else {//deleting, potentially
				uidDel.push(dgMember.selectedItems[i]);
			}
		}
		if(uidAdd != "") {
			//TW:cairngormTODO invoiceCFC.AddMember(selInvID,uidAdd);
		}
		if(uidDel.length > 0) {
			deleteMembers(uidDel, false);
		}
	}
	
	public function deleteMembers(uidDel:Array, deleteAll:Boolean):void {
	//Verify with user that they want to unselect
	
		//Check if the member(s) have any charge items
		var i2:int=0, len:int=uidDel.length;
		var haveCharges:Boolean=false;
		for(i2; i2 < len; i2++) {
			if(uidDel[i2].Charge.length > 0) {
				haveCharges = true;
				break;
			}
		}
		
		// If it's the first time, charges might not show up in MemberCharge
		if(!haveCharges) {
			var i3:int=0, len3:int=arChargeItem.length;
			for(i3;i3 < len3; i3++) {
				if(arChargeItem.getItemAt(i3).ItemIsSelected) {
					haveCharges = true;
					break;
				}
			}
		}
		//No charges in any selections -- simply delete with no prompt
		if(haveCharges) {
			popDeleteConfirm = null;
			popDeleteConfirm = popUpPost(PopUpManager.createPopUp(this, popUpPost, true));
			if(uidDel.length > 1) 
				popDeleteConfirm.messageText.text = "Remove All charges from members?";
			else
				popDeleteConfirm.messageText.text = "Remove All charges from member?";
			popDeleteConfirm.title = "Warning";
			popDeleteConfirm.postBack = uncheckMemCallBack;
			popDeleteConfirm.rollBack = uncheckMemRollBack;
		} else {
			uncheckMemCallBack();
			//return; 
		} 
		
		function uncheckMemCallBack():void {
			//format for Delete
			var delString:String;
			var i:int=0, len:int=uidDel.length;
			for(i; i < len; i++) {
				delString += uidDel[i].UserID;
				if(i+1 < len) {
					delString += ",";
				}
			}
			//TW:cairngormTODO invoiceCFC.DeleteMember(invoiceGrpID,delString);
			
			//If all unchecked, remove all charge checkboxes too
			if(deleteAll) {
				clearAllChargeItems();
			}
			//Clear selected Member List - automatic side-effect of DeleteMember
			//arMemberCharge = new Array();
			//dgMemberChrg.dataProvider = arMemberCharge;
			//dgMember.invalidateList();
			
		}
		function uncheckMemRollBack():void {
			//re-checkbox selected
			var b:Boolean;
			var i:int=0, len:int=uidDel.length;
			for(i; i < len; i++) {
				if(uidDel[i].IsSelected)
					uidDel[i].IsSelected = true;
			}
			dgMember.invalidateList();
			
		}
	}
	
	/*
		Here from dgSelCharge itemClick
		Process membercharge list and items selected / deselected
	*/
	public function addMemCharge(e:ListEvent):void
	{
		var i:int, j:int, mcLen:int, len:int, chargeID:int;
		var sel:ChargeItem;
		var args:InvoiceItemDAO = new InvoiceItemDAO;
		var ci:ChargeItem;
		var colIdx:int;
		var startT:int;
		var endT:int;

		if(invoiceIsPosted=="Y") return;
		
		colIdx = e.columnIndex;
		if(colIdx != 0) return; 				// ignore if not check box.
		args.InvoiceGrpID = _model.selectedInvoiceGroup.InvoiceGrpID;		// Global selected Invoice
		len = e.currentTarget.selectedItems.length;
		mcLen = arMemberCharge.length;
		startT = getTimer();
		// Selected Charge Items
		for(i=0; i<len; i++)
		{
			sel = e.currentTarget.selectedItems[i] as ChargeItem;
			chargeID = sel.ItemChargeID;
			args.ChargeItemID = sel.ItemChargeID;
			
			if(sel.ItemIsSelected)
			{
				//TW:cairngormTODO invoiceItemCFC.AddInvoiceItem(args);
				
				for(j=0; j<mcLen; j++)
				{
					ci = new ChargeItem(null);
					ci.ItemDup(sel);		// Copy for member
					arMemberCharge[j].addCharge(ci);
				}
			}
			else 		// Not selected
			{
				//TW:cairngormTODO invoiceItemCFC.DeleteInvoiceItem(args);
				for(j=0; j<mcLen; j++)
				{
					arMemberCharge[j].delCharge(chargeID);	
				}
			}
		}
	}
	/*
		Here from dgMemberChrg - Member Charge selected
	*/
	public function actionMember(e:Event):void
	{
		var mc:MemberClass;
		var en:Boolean;
		mc = e.currentTarget.selectedItem as MemberClass;
		en = mc.MemInvoice.IsPosted == "Y" ? true : false;
		//Alert.show("actionMember: "+mc);
		popMember = popUpMemberInvoice(PopUpManager.createPopUp(this, popUpMemberInvoice, true));
		popMember.mc = mc;
		popMember.dgMC = dgMemberChrg;
		popMember.PUdsn = dsn;
		popMember.PUendPoint = _endPoint;
		popMember.PUcallback = updateCharges;
		popMember.readOnly = en;
		popMember.btnPmail.enabled = mc.MemInvoice.IsPosted == "Y" ? false : true;
	}
	
	/*
		Here from dgMemberChrg - Member Charge selected
	*/
	public function actionMemberNotEditable(e:Event):void
	{
		var mc:MemberClass;
		var en:Boolean;
		//Alert.show("called actionMemberNoEdits: "+e.currentTarget.selectedItem);
		mc = e.currentTarget.selectedItem as MemberClass;
		//en = mc.MemInvoice.IsPosted == "Y" ? true : false;
		//Alert.show("actionMemberNoEdits: "+mc);
		popMember = popUpMemberInvoice(PopUpManager.createPopUp(this, popUpMemberInvoice, true));
		popMember.mc = mc;
		popMember.currentState = "LongAddyView";
		popMember.btnPmail.enabled = false;
		popMember.dgMC = dgMemberChrg; //WHY?
		popMember.PUdsn = dsn;
		popMember.PUendPoint = _endPoint;
		popMember.PUcallback = updateCharges;
	}
	
	public function handlePrint():void {
		//TW:cairngorm 
		var printEvent:PrintInvoiceEvent = new PrintInvoiceEvent(_model.selectedInvoiceGroup);
		CairngormEventDispatcher.getInstance().dispatchEvent(printEvent);
	}
	public function handlePrintPreview():void {
		//TW:cairngorm 
		var printEvent:PrintInvoiceEvent = new PrintInvoiceEvent(_model.selectedInvoiceGroup);
		CairngormEventDispatcher.getInstance().dispatchEvent(printEvent);
	}

}