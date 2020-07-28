package com.infusion.accounting.components.renderers
{
    import mx.controls.Label;
    import mx.controls.listClasses.*;

	[Bindable] 
    public class RegisterTotalBalanceRenderer extends Label 
    {
        private const POSITIVE_COLOR:uint = 0x000000; // Black
        private const NEGATIVE_COLOR:uint = 0xFF0000; // Red 

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            var n:Number;
            var s:String;

            /* Set the font color based on the item price. */
//            s = data.Balance;
//           n = Number(s.replace(",", ""));
            setStyle("color", (data.Balance < 0) ? NEGATIVE_COLOR : POSITIVE_COLOR);
        }
    }
}
