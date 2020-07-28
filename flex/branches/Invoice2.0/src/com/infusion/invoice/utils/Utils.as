package com.infusion.invoice.utils
{
	public class Utils
	{
		public function Utils()
		{
		}
		
		//From: http://blog.flexexamples.com/2007/08/12/sorting-date-columns-in-a-datagrid/
        private function date_sortCompareFunc(itemA:Object, itemB:Object):int {
            /* Date.parse() returns an int, but
               ObjectUtil.dateCompare() expects two
               Date objects, so convert String to
               int to Date. */
            //var dateA:Date = new Date(Date.parse(itemA.dob));
            var dateA:Date = new Date(itemA.MeetingDate);
            var dateB:Date = new Date(itemB.MeetingDate);
            return ObjectUtil.dateCompare(dateA, dateB);
        }

	}
}