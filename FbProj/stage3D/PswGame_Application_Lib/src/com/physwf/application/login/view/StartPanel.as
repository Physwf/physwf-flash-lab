package com.physwf.application.login.view
{
	import flash.events.MouseEvent;
	
	public class StartPanel extends PanelBase
	{
		public var onStartClick:Function;
		
		public function StartPanel(assetName:String)
		{
			super(assetName);
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
		
	}
}