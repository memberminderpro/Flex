package components
{
    import flash.text.FontStyle;
    
    import mx.controls.Label;
    import mx.controls.listClasses.*;
	
	public class NameLabelBoldSelReadOnlyRenderer extends Label {

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			/* For use in read-only situation - show selected as Bold instead */
			
            if(data.hasOwnProperty("IsSelected") && data.IsSelected) {
				setStyle("fontWeight", "bold");
			} else if(data.hasOwnProperty("ItemIsSelected") && data.ItemIsSelected) {
				setStyle("fontWeight", "bold");
			} else {
				setStyle("fontWeight", "normal");
			}
        }
    }
}
