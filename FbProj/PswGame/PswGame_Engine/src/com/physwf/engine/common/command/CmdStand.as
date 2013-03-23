package com.physwf.engine.common.command
{
	import com.physwf.components.command.Command;
	import com.physwf.engine.world.objects.Character;
	
	import flash.events.Event;
	
	public class CmdStand extends Command
	{
		private var mChara:Character;
		
		public function CmdStand(chara:Character)
		{
			mChara = chara;
		}
		
		override public function execute():void
		{
			mChara.stand();
			dispatchEvent(new Event(Command.FINISH));
		}
	}
}