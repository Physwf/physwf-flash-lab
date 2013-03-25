package com.physwf.application.input
{
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.events.MonsterEvent;
	import com.physwf.engine.common.events.PlayerEvent;
	import com.physwf.engine.frame.config.FrameAssets;
	import com.physwf.engine.world.objects.Character;
	import com.physwf.engine.world.objects.Monster;
	import com.physwf.engine.world.objects.NPC;
	import com.physwf.engine.world.objects.Player;
	import com.physwf.shell.interfaces.IDestroyable;
	import com.physwf.system.vo.MonsterInfo;
	import com.physwf.system.vo.UserInfo;
	
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
			Engine.map.view.swapLayer.addEventListener(MouseEvent.CLICK,onMouseClick);
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			var target:* = e.target;
			var manager:Character = Character.managers[target] as Character;
			if(manager is Monster)
			{
				Mouse.cursor = FrameAssets.CURSOR_AIM_NAME;
			}
			else if(manager is NPC)
			{
				Mouse.cursor = MouseCursor.BUTTON;
			}
			else
			{
				Mouse.cursor = MouseCursor.AUTO;
			}
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			var target:* = e.target;
			var manager:Character = Character.managers[target] as Character;
			if(manager is Monster)
			{
				var mInfo:MonsterInfo = (manager as Monster).info;
				Engine.challenge.dispatchEvent(new MonsterEvent(MonsterEvent.MONSTER_SELECTED,mInfo));
				e.stopImmediatePropagation();
			}
			else if(manager is Player)
			{
				var pInfo:UserInfo = (manager as Player).info;
				Engine.challenge.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYER_SELECTED,pInfo));
				e.stopImmediatePropagation();
			}
		}
		
		public function dispose():void
		{
			mRoot.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			mRoot = null;
		}
	}
}