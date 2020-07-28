package com.sample
{
	import com.sample.model.Address;
	
	import mx.formatters.CurrencyFormatter;
	import mx.formatters.DateFormatter;
	
	/**
	 * Utility class to handle most UI manipulations 
	 */	
	public class SampleUIUtils
	{
		
		/**
		 * Formats the data in date format 
		 * @param item Item to format
		 * @param column Column that displays the property
		 * @return Formatted date
		 */		
		public static function dataGridFormatDate(item:Object, column:Object):String
		{
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = "MM/DD/YY";
			return dateFormatter.format(item[column.dataField]);
		}
		/**
		 * Formats the data in Currency format 
		 * @param item Item to format
		 * @param column Column that displays the property
		 * @return Formatted Currency
		 */		
		public static function dataGridFormatCurrency(item:Object, column:Object):String
		{
			var currencyFormatter:CurrencyFormatter = new CurrencyFormatter();
			return currencyFormatter.format(item[column.dataField]);
		}
		/**
		 * Formats the data in Currency format 
		 * @param item Item to format
		 * @param column Column that displays the property
		 * @return Formatted Currency
		 */		
		public static function dataGridFormatCurrencyWithCents(item:Object, column:Object):String
		{
			return currencyFormatterWithCents.format(item[column.dataField]);
		}
		
		public static function get currencyFormatterWithCents():CurrencyFormatter{
			var currencyFormatterWithCents:CurrencyFormatter = new CurrencyFormatter();
			currencyFormatterWithCents.precision=2;
			return currencyFormatterWithCents;
		}
		
		public static function dataGridFormatAddress(item:Object, column:Object):String
		{
			var address:Address=(item[column.dataField] as Address);
			return address!=null?address.concatenatedAddress:"";
		}
		
	}
}