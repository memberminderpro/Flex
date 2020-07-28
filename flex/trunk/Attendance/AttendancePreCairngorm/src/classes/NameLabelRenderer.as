package classes
{
    import flash.text.FontStyle;
    
    import mx.controls.Label;
    import mx.controls.listClasses.*;
	
	public class NameLabelRenderer extends Label {
		var fontSize:int = 11;

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			/* Set name based on user type */
			//Before initial upload of guest or if it's not a guest
            if(data.ClubAttendanceID == 0 || data.GuestCode == 0) { 
				text = data.UserName;
			} else { //after round-trip to server
	            // data.Notes is in form:  Guest name[|other info]
            	text = data.Notes.split("|", 1)[0];	
            	if(data.GuestCode == 1) {
            		text = text+" ("+data.UserName+")"; //(Name of Hosting Member)
            	} 
   			}
		
            /* Set the font color based on type */
			if(data.GuestCode > 0) {
				setStyle("color", "BLACK");
			} else if(data.Excused) {
            	setStyle("color", "LIGHTGREY");
            } else if(data.Rof85 && data.boolAttended){
            	setStyle("color", "GREEN");
            } else if(!data.Counts && data.boolAttended) {
            	setStyle("color", "LIGHTGREY");
            } else {
            	setStyle("color", "BLUE");
            }
            
            /* Set the font size for the over-50 crowd */
            setStyle("fontSize", fontSize); 
            
        }
    }
}
