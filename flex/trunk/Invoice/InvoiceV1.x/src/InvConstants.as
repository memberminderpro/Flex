// ActionScript file
// Constants
/*
1 Per Member Y 1 1
2 Per MemberType Y 2 2
3 Per Meeting Attended Y 9 5
4 Per Meeting Missed Y 8 6
5 Per Member Recurring Y 4 3
6 Per Make-Up Meeting Y 8 4
7 Per Mtg Attended (MemberType) Y 10 7
8 Per MealCode Y 25 8
9 Outstanding Balance N 0 9
10 Per Member Selected Y 33 3
11 Per Mtg Missed (MemberType) Y 10 7
12 Per Mtg Excused Y 9 8
13 Per Mtg Y 9 8
14 Per Mtg (Member Type) Y 10 14
14 Per Club Type Y 64 15
[10:04:36 PM] Mark Landmann says: chargeTypeID, ChargeType, IsActive, TypeID, PositionSort
*/
		public static const valRecurring:int = 2;
		public static const perMember:int = 1; //1 = 00001
		public static const perMemberType:int = 2; //2 = 00010
		public static const perMeetingAttended:int = 3; //9 = 01001
		public static const perMeetingMissed:int = 4; //9 = 01001
		public static const perMemberRecurring:int = 5; //4 = 00100
		public static const perMakeUp:int = 6; //9 = 01001
		public static const perMeetingAttendedMemberType:int = 7; //10 = 01010 
		public static const perMealCode:int = 8; //25 = 11001 WTF?
		public static const perOutstanding:int = 9; //0 Not used
		public static const perMemberSelected:int = 10; //33 = 10001
		public static const perMeetingMissedMemberType:int = 11; //10 = 01010
		public static const perExcusedLOAMeeting:int = 12; //9 = 01001
		public static const perMeeting:int = 13; //9 = 01001
		public static const perMeetingMemberType:int = 14; //10 = 01010
		public static const perClubType:int = 15; //64 = 100000
