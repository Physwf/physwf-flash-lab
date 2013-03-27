package com.physwf.application.debug.console
{
	import flash.display.Sprite;

	public class Console
	{
		private var input:ConsoleInput;
		private var mRoot:Sprite;
		private var toggleFlag:Boolean = false;
		
		public function Console(root:Sprite)
		{
			mRoot = root;
			input = new ConsoleInput(root);
			Command.initialize();
		}
		
		public function toogle():void
		{
			toggleFlag = !toggleFlag;
			if(toggleFlag)
			{
				input.x = mRoot.stage.stageWidth - input.width;
				input.show();
			}
			else
			{
				input.x = mRoot.stage.stageWidth;
				input.hide();
			}
		}
		
		public function log(info:Object):void
		{
			input.appendText(info.toString()+"\n");
		}
	}
}