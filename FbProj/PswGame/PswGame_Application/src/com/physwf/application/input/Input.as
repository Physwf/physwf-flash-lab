package com.physwf.application.input
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.engine.frame.config.FrameAssets;
	import com.physwf.engine.world.manager.Character;
	import com.physwf.engine.world.manager.Monster;
	import com.physwf.shell.interfaces.IDestroyable;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;

	public class Input implements IDestroyable
	{
		private var mRoot:Sprite;
		
		public function Input(root:Sprite)
		{
			mRoot = root;
		}
		
		public function initialize():void
		{
			mRoot.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			var target:* = e.target;
			var manager:Character = Character.managers[target] as Character;
			if(manager is Monster)
			{
				Mouse.cursor = FrameAssets.CURSOR_AIM_NAME;
			}
			else
			{
				Mouse.cursor = MouseCursor.AUTO;
			}
		}
		
		public function dispose():void
		{
			mRoot.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			mRoot = null;
		}
	}
}