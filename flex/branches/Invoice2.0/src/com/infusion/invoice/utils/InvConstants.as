package com.infusion.invoice.utils {

// ActionScript file
// Constants
/*
1 Per Member Y 1 1
2 Per MemberType Y 2 2
3 Per Meeting Attended Y 8 5
4 Per Meeting Missed Y 8 6
5 Per Member Recurring Y 4 3
6 Per Make-Up Meeting Y 8 4
7 Per Mtg Attended (MemberType) Y 10 7
8 Per MealCode Y 25 8
9 Outstanding Balance N 0 9
10 Per Member Selected Y 33 3
11 Per Mtg Missed (MemberType) Y 10 7
[10:04:36 PM] Mark Landmann says: chargeTypeID, ChargeType, IsActive, TypeID, PositionSort
*/
public class InvConstants {
		public static const valRecurring:int = 2;
		public static const perMember:int = 1; //1
		public static const perMemberType:int = 2; //2
		public static const perMeetingAttended:int = 3; //8
		public static const perMeetingMissed:int = 4; //8
		public static const perMemberRecurring:int = 5; //4
		public static const perMakeUp:int = 6; //8
		public static const perMeetingAttendedMemberType:int = 7; //10
		public static const perMealCode:int = 8; //25
		public static const perOutstanding:int = 9; //0 Not used
		public static const perMemberSelected:int = 10; //33
		public static const perMeetingMissedMemberType:int = 11; //10
		public static const perExcusedLOAMeeting = 12;
}
}