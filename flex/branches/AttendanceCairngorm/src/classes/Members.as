package classes
{
	import flash.events.Event;
	
	import mx.events.*;

	[Bindable]
	public class Members
	{
		private var _UserID:int;
		private var _UserName:String;
		private var _MemberID:int; //TODO: remove, never gets used
		private var _MemberTypeID:int;
		private var _ClubAttendanceID:int;
		private var _ClubMeetingID:int;
		private var _MemberType:String;
		private var _Attended:String;
		private var _MeetingDate:Date;
		private var _Notes:String;
		private var _Counts:Boolean;
		private var _Makeup:Boolean;
		private var _Excused:Boolean;
		private var _Rof85:Boolean;
		private var _MealCode:int;
		private var _GuestCode:int;
		private var _idx:int;
		
		private var today:Date = new Date();
		
		public function loadData(obj:Object):void
		{
			if(obj != null)
			{
				_UserID = obj.UserID;
				_UserName = obj.UserName;
				_MemberID = obj.MemberID;
				_ClubMeetingID = obj.ClubMeetingID;
				_ClubAttendanceID = obj.ClubAttendanceID;
				_Attended = obj.Attended;
				_MemberType = obj.MemberType;
				_MemberTypeID = obj.MemberTypeID;
				_MeetingDate = obj.MeetingDate;
				_Notes = obj.Notes;
				_Counts = obj.Counts;
				_Makeup = obj.Makeup;
				_Excused = obj.Excused;
				_Rof85 = obj.Rof85;
				_MealCode = obj.MealCode;
				_GuestCode = obj.GuestCode;
				_idx = obj.Idx;
			}
		}
		public function enterEvent():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
			// Setters & Getters
		public function set Notes(s:String):void
		{
			_Notes = s;	
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function get Notes():String
		{
			return _Notes;
		}
		
		public function set UserID(i:int):void
		{
			_UserID = i;
		}
		public function get UserID():int
		{
			return _UserID;
		}
		public function set Idx(idx:int):void
		{
			_idx = idx;
		}
		public function get Idx():int
		{
			return _idx;
		}
		public function set UserName(s:String):void
		{
			_UserName = s;
		}
		public function get UserName():String
		{
			return _UserName;
		}
		public function set Attended(s:String):void
		{
			_Attended = s;
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function get Attended():String
		{
			return _Attended;
		}
		public function set boolAttended(b:Boolean):void
		{
			_Attended = b ? "Y" : "N";
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function get boolAttended():Boolean
		{
			var b:Boolean = false;
			if(_Attended == "Y") {b = true};
			if(_Attended == "N") {b = false};
			return b;
		}
		public function set ClubMeetingID(i:int):void
		{
			_ClubMeetingID = i;
		}
		public function get ClubMeetingID():int
		{
			return _ClubMeetingID;
		}
		public function set ClubAttendanceID(i:int):void
		{
			_ClubAttendanceID = i;
		}
		public function get ClubAttendanceID():int
		{
			return _ClubAttendanceID;
		}
		public function set MeetingDate(d:Date):void
		{
			_MeetingDate = d;
		}
		public function get MeetingDate():Date
		{
			return _MeetingDate;
		}
		public function set MemberType(s:String):void
		{
			_MemberType = s;
		}
		public function get MemberType():String
		{
			return _MemberType;
		}
		public function set MemberTypeID(i:int):void
		{
			_MemberTypeID = i;
		}
		public function get MemberTypeID():int
		{
			return _MemberTypeID;
		}
		
		public function set Counts(b:Boolean):void
		{
			_Counts = b;
			//TODO dispatchEvent(new Event(Event.CHANGE));
		}
		public function get Counts():Boolean
		{
			return _Counts;
		}
		public function set Makeup(b:Boolean):void
		{
			_Makeup = b;
			//TODO dispatchEvent(new Event(Event.CHANGE));
		}
		public function get Makeup():Boolean
		{
			return _Makeup;
		}
		public function set Excused(b:Boolean):void
		{
			_Excused = b;
			//TODO dispatchEvent(new Event(Event.CHANGE));
		}
		public function get Excused():Boolean
		{
			return _Excused;
		}
		public function set Rof85(b:Boolean):void
		{
			_Rof85 = b;
			//TODO dispatchEvent(new Event(Event.CHANGE));
		}
		public function get Rof85():Boolean
		{
			return _Rof85;
		}
		public function set MealCode(i:int):void
		{
			_MealCode = i;
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function get MealCode():int
		{
			return _MealCode;
		}
		public function set GuestCode(i:int):void
		{
			_GuestCode = i;
			//TODO dispatchEvent(new Event(Event.CHANGE));
		}
		public function get GuestCode():int
		{
			return _GuestCode;
		}
	}
}