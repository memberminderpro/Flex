package com.infusion.attendanceoffline.model.dtos
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Meeting
	{
		public function Meeting(o:Object) {
			Attended = o.Attended;
			ClubID = o.ClubID;
			ClubMeeting = o.ClubMeeting;
			ClubMeetingID = o.ClubMeetingID;
			ClubName = o.ClubName;
			Created_By = o.Created_By;
			Created_Tmstmp = o.Created_Tmstmp;
			Exempt = o.Exempt;
			IsExcluded = o.IsExcluded;
			IsOpen = o.IsOpen;
			MakeUp = o.MakeUp;
			MeetingDate = o.MeetingDate;
			Modified_By = o.Modified_By;
			Modified_Tmstmp = o.Modified_Tmstmp;
			Total = o.Total;
		}
		public var Attended:int;
		public var ClubID:int;
		public var ClubMeeting:String;
		public var ClubMeetingID:int;
		public var ClubName:String;
		public var Created_By:int;
		public var Created_Tmstmp:Date;
		public var Exempt:int;
		public var IsExcluded:String;
		public var IsOpen:Boolean;
		public var MakeUp:int;
		public var MeetingDate:Date;
		public var Modified_By:int;
		public var Modified_Tmstmp:Date;
		public var Total:int;
		
		//Calculated
		public var attdPercent:String = "";		
		public var attdTotal:String = "";		
		public var attdCount:String = "";
		
		public var members:ArrayCollection = new ArrayCollection();
//		public var lastSaved:Date;
//		public var lastModified:Date;
//		public var dirty:Boolean;
				
		public function toString():String {
			var s:String = "Meeting={";
			s += "\n\tclubMeetingID:"+ClubMeetingID;
			s += "\n\tclubMeeting:"  +ClubMeeting;
			return s;
		}
	}
	
//	public function calculateAttendance():void {
// 			/*
// 			Attendance calculation algorithm, approved by RI in 2007:
// 			AO = Active + LOA (Total eligible for attendance per meeting
// 			AE = Active - Rule of 85 members
// 			Thus, per the new rules, the attendance calculation is:
// 			Attendance % = (AO + AE attending)/(AO Total + AE attending)
// 			=(Active.attd + LOA.attd + (Active.attd - Rule of 85.attd))/
// 			     (Active.total + LOA.total + (Active.attd - Rule of 85.attd)
// 			     
// 			     Exempt members don't count in totals 
// 			*/
// 			//loop through each member
// 			var activeTotal:int = 0, activeAttd:int = 0;
// 			var ro85Total:int = 0, ro85Attd:int = 0;
// 			var loaTotal:int = 0, loaAttd:int = 0;
// 			var m:Members;
// 			var i:int = 0;
// 			for(i=0; i < acMembers.length; i++) {
// 				m = acMembers.getItemAt(i) as Members;
// 				if(m.GuestCode != 0) continue;
// 				if(m.Excused) {
// 					continue;
// 				} 
// 				if(!m.Counts && m.MemberType != "Active-Rule of 85") {
// 					//Alert.show("Not counting: "+m.UserName +", "+m.MemberType);		
// 					continue;
// 				}
// 				
//				if(m.MemberType == "Active-Rule of 85") {
//					if(m.boolAttended) {
// 						ro85Attd++;
// 						ro85Total++;  
// 					}
// 				} else {
// 					activeTotal++;
// 					if(m.boolAttended)  activeAttd++;
// 				} 
// 			}
// 			//attdPercent = ((activeAttd + loaAttd + activeAttd - ro85Attd)/(activeTotal + loaTotal + activeAttd - ro85Attd) * 100.0).toString();
// 			attdPercent = ((activeAttd + loaAttd + ro85Attd)/(activeTotal + loaTotal + ro85Total) * 100.0 ).toString();
// 			attdCount = (activeAttd + ro85Attd + loaAttd).toString();
// 			attdTotal = (activeTotal + ro85Total + loaTotal).toString();
// 			//attd1.invalidateDisplayList();
// 			attd1.validateDisplayList();
// 			attd2.validateDisplayList();
// 			attd3.validateDisplayList();
// 			//update this info in the local meetings db and datagrid
// 			
// 			     
// 		}
}