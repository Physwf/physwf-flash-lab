package com.physwf.application.login.view
{
	import flash.events.MouseEvent;
	
	public class StartPanel extends PanelBase
	{
		public var onStartClick:Function;
		
		public function StartPanel(assetName:String)
		{
			super(assetName);
			asset.x = 1000/2;
			asset.y = 520;
		}
		
		override protected function onClick(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "btnStart":
					onStartClick();
					break;
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			onStartClick = null;
		}
		
	}
}