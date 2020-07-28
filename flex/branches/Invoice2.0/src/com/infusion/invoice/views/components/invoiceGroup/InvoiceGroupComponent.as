package com.infusion.invoice.views.components.invoiceGroup
{
	import com.infusion.invoice.model.dtos.InvoiceGroup;
	
	import mx.containers.VBox;

	public class InvoiceGroupComponent extends VBox
	{
		[Bindable] public var invoiceGroup:InvoiceGroup;
		public function InvoiceGroupComponent()
		{
			super();
		}
		
	}
}