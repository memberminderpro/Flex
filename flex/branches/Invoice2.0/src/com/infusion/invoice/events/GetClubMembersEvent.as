package com.infusion.invoice.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class GetClubMembersEvent extends CairngormEvent
	{
		public static var GET_CLUB_MEMBERS:String = "getClubMembers";
		//{ClubID:clubID,Override:"",TermDate:null}
		public var clubID:int;
		public var isOverride:Boolean;
		public var terminationDate:Date;
		
		/**
		 * Constructor.
		 */
		public function GetClubMembersEvent(clubID:int, isOverride:Boolean, terminationDate:Date, 
			bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super( GET_CLUB_MEMBERS, bubbles, cancelable );
			this.clubID = clubID;
			this.isOverride = isOverride;
			this.terminationDate = terminationDate;
		}
     	
     	/**
     	 * Override the inherited clone() method, but don't return any state.
     	 */
		override public function clone() : Event
		{
			return new GetClubMembersEvent(clubID, isOverride, terminationDate, true, true);
		}	
	}
	
}