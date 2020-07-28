package com.infusion.attendanceoffline.model.dtos
{

	[Bindable]
	public class Member
	{
		public var userID:int;
		public var userName:String;
		public var memberTypeID:int;
		public var clubAttendanceID:int;
		public var clubMeetingID:int;
		public var memberType:String;
		public var attended:String;
		public var meetingDate:Date;
		public var notes:String;
		public var counts:Boolean;
		public var makeup:Boolean;
		public var excused:Boolean;
		public var ruleOf85:Boolean;
		public var mealCode:int;
		public var guestCode:int;
		public var idx:int; //TODO what is this?
		
		public var today:Date = new Date();
	}
}