package com.infusion.invoice.commands
{
	import com.adobe.cairngorm.control.FrontController;
	import com.infusion.invoice.events.AddAllMemberToInvoiceGroupEvent;
	import com.infusion.invoice.events.CreateChargeItemEvent;
	import com.infusion.invoice.events.CreateInvoiceGroupEvent;
	import com.infusion.invoice.events.DeleteChargeItemEvent;
	import com.infusion.invoice.events.DeleteInvoiceGroupEvent;
	import com.infusion.invoice.events.GetAccountsXMLEvent;
	import com.infusion.invoice.events.GetAllChargeItemsEvent;
	import com.infusion.invoice.events.GetAllInvoiceGroupsForClubEvent;
	import com.infusion.invoice.events.GetChargeTypesEvent;
	import com.infusion.invoice.events.GetClubMembersEvent;
	import com.infusion.invoice.events.GetMemberTypesEvent;
	import com.infusion.invoice.events.UpdateChargeItemEvent;
	import com.infusion.invoice.events.UpdateInvoiceGroupEvent;
	import com.infusion.invoice.events.ViewInvoiceEvent;	

	public class Controller extends FrontController
	{
		public function Controller()
		{
			initialiseCommands();
		}
		
		public function initialiseCommands() : void
		{
			//addCommand( MessageEvent.GET_MESSAGE, GetMessageCommand );
			addCommand(GetAllInvoiceGroupsForClubEvent.GET_ALL_INVOICE_GROUPS, GetAllInvoiceGroupsForClubCommand);
			//addCommand(LoginEvent.LOGIN, LoginCommand);
			//addCommand(GetMealCodesEvent.MEAL_CODES, GetMealCodesCommand);
			
			addCommand(GetAllChargeItemsEvent.GET_ALL_CHARGE_ITEMS, GetAllChargeItemsCommand);
			addCommand(CreateChargeItemEvent.CREATE_CHARGE_ITEM, CreateChargeItemCommand);
			addCommand(DeleteChargeItemEvent.DELETE_CHARGE_ITEM, DeleteChargeItemCommand);
			addCommand(UpdateChargeItemEvent.UPDATE_CHARGE_ITEM, UpdateChargeItemCommand);
			addCommand(GetAccountsXMLEvent.GET_ACCOUNTS_XML, GetAccountsXMLCommand);
			addCommand(GetClubMembersEvent.GET_CLUB_MEMBERS, GetClubMembersCommand);
			addCommand(GetMemberTypesEvent.GET_MEMBER_TYPES, GetMemberTypesCommand);
			addCommand(GetChargeTypesEvent.GET_CHARGE_TYPES, GetChargeTypesCommand);
			addCommand(ViewInvoiceEvent.VIEW_INVOICE, ViewInvoiceCommand);
			addCommand(CreateInvoiceGroupEvent.CREATE_INVOICE_GROUP, CreateInvoiceGroupCommand);
			addCommand(UpdateInvoiceGroupEvent.UPDATE_INVOICE_GROUP, UpdateInvoiceGroupCommand);
			addCommand(DeleteInvoiceGroupEvent.DELETE_INVOICE_GROUP, DeleteInvoiceGroupCommand);
			
			addCommand(AddAllMemberToInvoiceGroupEvent.ADD_ALL_MEMBERS_TO_INVOICE_GROUP, AddAllMembersToInvoiceGroupCommand);
		}
	}
	
}