package com.physwf.engine.command
{
	import com.physwf.engine.world.events.CharacterEvent;
	import com.physwf.engine.world.manager.Character;
	import com.physwf.system.System;
	
	import flash.events.Event;
	import com.physwf.components.command.Command;

	/**
	 * 寻路到指定点 
	 * @author joe
	 * 
	 */
	public class CmdWalkTo extends Command
	{
		private var mChara:Character;
		private var endX:uint;
		private var endY:uint;
		
		public function CmdWalkTo(chara:Character)
		{
			mChara = chara;
		}
		
		public function setDest(ex:uint,ey:uint):void
		{
			endX = ex;
			endY = ey;
		}
		
		override public function execute():void
		{
			mChara.addEventListener(CharacterEvent.CHARA_PATH_FINISH,onPathFinish);
//			System.myself.move(endX,endY,0);
			mChara.goto(endX,endY);
		}
		
		private function onPathFinish(e:CharacterEvent):void
		{
			mChara.removeEventListener(CharacterEvent.CHARA_PATH_FINISH,onPathFinish);
			dispatchEvent(new Event(Command.FINISH));
		}
	}
}