package classes
{
	/*
	"CREATE TABLE IF NOT EXISTS	meeting (" +
			" ClubMeetingID PRIMARY KEY, " +
			" Attended INTEGER, " +
			" Exempt INTEGER, " +
			" MakeUp INTEGER, " +
			" ClubID INTEGER, " +
			" Total INTEGER, " +
			" ClubMeeting TEXT, " +
			" ClubName TEXT, " +
			" IsOpen TEXT, " +
			" MeetingDate TEXT, " +
			" LastSaved TEXT, " +
			" LastModified TEXT, " +
			" Dirty INTEGER );"; 
			*/	
	import flash.events.Event;
	
	import mx.events.*;

	[Bindable]
	public class Meeting
	{
		private var _ClubMeetingID:int;
		private var _Attended:int;
		private var _Exempt:int;
		private var _MakeUp:int;
		private var _ClubID:int;
		private var _Total:int;
		private var _ClubMeeting:String; 
		private var _ClubName:String;
		private var _IsOpen:Boolean;
		private var _MeetingDate:Date;
		private var _LastSaved:Date;
		private var _LastModified:Date;
		private var _Dirty:Boolean;
		
		private var today:Date = new Date();
		
		public function loadData(obj:Object):void
		{
			if(obj != null)
			{
				_ClubID = obj.ClubID;
				_Total = obj.Total;
				_ClubMeeting = obj.ClubMeeting;
				_ClubMeetingID = obj.ClubMeetingID;
				_IsOpen = obj.IsOpen;
				_Attended = obj.Attended;
				_LastSaved = obj.LastSaved;
				_ClubName = obj.ClubName;
				_MeetingDate = obj.MeetingDate;
				_LastModified = obj.LastModified;
				_Dirty = obj.Dirty;
				_MakeUp = obj.MakeUp;
				_Exempt = obj.Exempt;
			}
		}
		public function enterEvent():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
			// Setters & Getters
		public function set LastModified(d:Date):void
		{
			_LastModified = d;	
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function get LastModified():Date
		{
			return _LastModified;
		}
		
		public function set ClubID(i:int):void
		{
			_ClubID = i;
		}
		public function get ClubID():int
		{
			return _ClubID;
		}
		public function set Total(i:int):void
		{
			_Total = i;
		}
		public function get Total():int
		{
			return _Total;
		}
		public function set Attended(i:int):void
		{
			_Attended = i;
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function get Attended():int
		{
			return _Attended;
		}
		public function set ClubMeetingID(i:int):void
		{
			_ClubMeetingID = i;
		}
		public function get ClubMeetingID():int
		{
			return _ClubMeetingID;
		}
		public function set IsOpen(b):void
		{
			_IsOpen = b;
		}
		public function get IsOpen():Boolean
		{
			return _IsOpen;
		}
		public function set MeetingDate(d:Date):void
		{
			_MeetingDate = d;
		}
		public function get MeetingDate():Date
		{
			return _MeetingDate;
		}
		public function set LastSaved(d:Date):void
		{
			_LastSaved = d;
		}
		public function get LastSaved():Date
		{
			return _LastSaved;
		}
		public function set ClubName(s:String):void
		{
			_ClubName = s;
		}
		public function get ClubName():String
		{
			return _ClubName;
		}
		
		public function set Dirty(b:Boolean):void
		{
			_Dirty = b;
			//TODO dispatchEvent(new Event(Event.CHANGE));
		}
		public function get Dirty():Boolean
		{
			return _Dirty;
		}
		public function set MakeUp(i:int):void
		{
			_MakeUp = i;
			//TODO dispatchEvent(new Event(Event.CHANGE));
		}
		public function get MakeUp():int
		{
			return _MakeUp;
		}
		public function set Exempt(i:int):void
		{
			_Exempt = i;
			//TODO dispatchEvent(new Event(Event.CHANGE));
		}
		public function get Exempt():int
		{
			return _Exempt;
		}
		public function set ClubMeeting(s:String):void
		{
			_ClubMeeting = s;
		}
		public function get ClubMeeting():String
		{
			return _ClubMeeting;
		}
		
	}
}