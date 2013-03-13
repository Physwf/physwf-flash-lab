package com.physwf.engine.command
{
	import com.physwf.components.command.Command;
	import com.physwf.engine.world.manager.Character;
	
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
		}
	}
}