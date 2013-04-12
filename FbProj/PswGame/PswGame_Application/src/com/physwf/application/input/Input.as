package com.physwf.application.input
{
	import com.physwf.components.ui.DragManager;
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.events.CellEvent;
	import com.physwf.engine.common.events.CharacterEvent;
	import com.physwf.engine.frame.config.FrameAssets;
	import com.physwf.engine.world.objects.Character;
	import com.physwf.engine.world.objects.Monster;
	import com.physwf.engine.world.objects.NPC;
	import com.physwf.engine.world.objects.Player;
	import com.physwf.shell.interfaces.IDestroyable;
	import com.physwf.system.vo.MonsterInfo;
	import com.physwf.system.vo.UserInfo;
	
	import flash.display.Bitmap;
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
			mRoot.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			mRoot.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			mRoot.addEventListener(MouseEvent.CLICK,onMouseClick);
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
		
		private function onMouseDown(e:MouseEvent):void
		{
			var target:* = e.target;
			if(target is Cell)
			{
				var cell:Cell = target as Cell;
				if(cell.location == Cell.LOCATION_SKILLBAR)
				{
					Engine.frame.dispatchEvent(new CellEvent(CellEvent.CELL_PRESSED,cell));
				}
				else if(cell.location == Cell.LOCATION_BAG)
				{
					Engine.bag.dispatchEvent(new CellEvent(CellEvent.CELL_PRESSED,cell));
				}
			}
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			var target:* = e.target;
			if(target is Cell)
			{
				var cell:Cell = target as Cell;
				if(cell.location == Cell.LOCATION_SKILLBAR)
				{
					Engine.frame.dispatchEvent(new CellEvent(CellEvent.CELL_RELEASED,cell));
				}
				else if(cell.location == Cell.LOCATION_BAG)
				{
					Engine.bag.dispatchEvent(new CellEvent(CellEvent.CELL_RELEASED,cell));
				}
			}
			DragManager.instance.dragItem = null;
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			var target:* = e.target;
			
			if(target is Cell)
			{
				var cell:Cell = target as Cell;
				if(cell.location == Cell.LOCATION_SKILLBAR)
				{
					Engine.frame.dispatchEvent(new CellEvent(CellEvent.CELL_CLICKED,cell));
				}
				else if(cell.location == Cell.LOCATION_BAG)
				{
					Engine.bag.dispatchEvent(new CellEvent(CellEvent.CELL_CLICKED,cell));
				}
				e.stopImmediatePropagation();
				return;
			}
			
			var manager:Character = Character.managers[target] as Character;
			if(manager is Monster)
			{
				var mInfo:MonsterInfo = (manager as Monster).info;
				Engine.challenge.dispatchEvent(new CharacterEvent(CharacterEvent.MONSTER_SELECTED,manager));
				e.stopImmediatePropagation();
			}
			else if(manager is Player)
			{ 
				var pInfo:UserInfo = (manager as Player).info;
				Engine.challenge.dispatchEvent(new CharacterEvent(CharacterEvent.PLAYER_SELECTED,manager));
				e.stopImmediatePropagation();
			}
			else if(manager is NPC)
			{
//				new CharacterEvent(CharacterEvent.
			}
		}
		
		public function dispose():void
		{
			mRoot.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			mRoot = null;
		}
	}
}