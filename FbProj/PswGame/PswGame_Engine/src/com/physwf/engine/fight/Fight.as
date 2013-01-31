package com.physwf.engine.fight
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.engine.fight.manager.Challenge;

	public class Fight implements IUpdatable
	{
		public static const FIGHT_CHARA_TYPE_PLAYER:uint = 0;
		public static const FIGHT_CHARA_TYPE_PET:uint = 1;
		public static const FIGHT_CHARA_TYPE_NPC:uint = 2;
		
		private var mChallenge:Challenge;
		
		public function Fight()
		{
		}
		
		public function initialize():void
		{
			mChallenge = new Challenge();
			mChallenge.initialize();
		}
		
		public function update():void
		{
			mChallenge.update();
		}
	}
}