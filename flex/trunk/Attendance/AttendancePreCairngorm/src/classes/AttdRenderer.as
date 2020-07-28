package classes
{
	import mx.controls.Button;

	public class AttdRenderer extends Button
	{
		[Bindable]
        public var returnAttd:Boolean = false;
		public function AttdRenderer()
		{
             super(); 
			 toggle=true;

         } 
         
         private function render(theValue:Object):void {
         		if(theValue.boolAttended)  selected = true;
         		
            		if(theValue.GuestCode > 0 ) {
            			label = "G";
            		} else if(theValue.Excused) {
            			label = "X";
            		} else if(theValue.Makeup) {
            			label = "M";
            		} else if(theValue.boolAttended) {
            			label = "Y";
            		} else {
            			label = "-";
            		}	
            }
  
         // Override the set method for the data property. 
         override public function set data(value:Object):void { 
             super.data = value; 
             // Since the item renderer can be recycled,  
             // set the initial background color.          
             if (value != null) 
             { 
                render(value);
             } 
  
             else 
             { 
                 // If value is null, clear text. 
                 label= "--"; 
             } 
             returnAttd = value;
  
             super.invalidateDisplayList(); 
         } 

		
	}
}