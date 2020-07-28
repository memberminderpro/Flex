package accounts
{
	import mx.collections.*;
	import mx.controls.treeClasses.*;
    
	public class AcctTreeRenderer extends TreeItemRenderer
	{
		private var posting:Boolean;
		public function AcctTreeRenderer()
		{
			super();
		}
        // Override the set method for the data property       
        override public function set data(value:Object):void 
        {
            super.data = value;
            posting = (value.@IsPosting == "Y") ? true : false;
            if(!TreeListData(super.listData).hasChildren) //leaf node
            {
            	if(! posting) //not posting = not open to deposit into
            	{
            		this.setStyle("color", 0xa5aeb8);
            		this.setStyle("fontStyle", "italic");
           		} else { //TW: is posting, so make it look normal
           			this.setStyle("color", "black");
            		this.setStyle("fontStyle", "normal");
           		}
           	} else {
           		//TW: does have children, so not clickable
           		this.setStyle("color", 0xa5aeb8);
            	this.setStyle("fontStyle", "italic");
           	}
        }
     
        // Override the updateDisplayList() method 
        // to set the text for each tree node. 
        /*     
        override protected function updateDisplayList(unscaledWidth:Number, 
            unscaledHeight:Number):void {
       
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            if(super.data)
            {
                if(TreeListData(super.listData).hasChildren)
                {
                    var tmp:XMLList = 
                        new XMLList(TreeListData(super.listData).item);
                    var myStr:int = tmp[0].children().length();
                    super.label.text =  TreeListData(super.listData).label + 
                        "(" + myStr + ")";
                }
            }
        }
        */
    }
}
