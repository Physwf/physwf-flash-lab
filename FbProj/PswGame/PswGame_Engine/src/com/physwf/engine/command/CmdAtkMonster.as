package com.physwf.engine.command
{
	import com.physwf.engine.fight.Fight;
	import com.physwf.engine.world.manager.Character;
	import com.physwf.engine.world.manager.Player;
	import com.physwf.system.System;

	public class CmdAtkMonster extends Command
	{
		private var mChara:Character;
		private var target:Character;
		private var targetID:uint;
		
		public function CmdAtkMonster(chara:Character)
		{
			mChara = chara;
		}
		
		public function setTarget(tgt:Character,mid:uint):void
		{
			target = tgt;
			targetID = mid;
		}
		
		override public function execute():void
		{
			//to do 特效
			mChara.attack();
			System.fight.attack(Fight.FIGHT_CHARA_TYPE_PLAYER,Fight.FIGHT_CHARA_TYPE_NPC,
								targetID,1);
		}
	}
}