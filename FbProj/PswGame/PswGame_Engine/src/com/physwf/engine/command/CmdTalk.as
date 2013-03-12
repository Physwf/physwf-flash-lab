package com.physwf.engine.command
{
	import com.physwf.components.command.Command;
	import com.physwf.engine.world.manager.Character;
	
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class CmdTalk extends Command
	{
		public var duration:uint;//该命令的持续时间
		
		private var mChara:Character;
		private var mStartTime:uint;
		
		public function CmdTalk(chara:Character)
		{
			mChara = chara;
		}
		
		override public function execute():void
		{
			mStartTime = getTimer();
			//to do 冒泡
		}
		
		override public function update():void
		{
			if(duration <= getTimer() - mStartTime)
			{
				dispatchEvent(new Event(Command.FINISH));
			}
		}
	}
}