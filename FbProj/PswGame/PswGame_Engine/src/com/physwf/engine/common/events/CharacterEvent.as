package com.physwf.engine.common.events
{
	import com.physwf.engine.world.objects.Character;
	
	import flash.events.Event;
	
	public class CharacterEvent extends Event
	{
		public static const PLAYER_SELECTED:String = "c_s";
		public static const PLAYER_DIE:String = "c_d";
		
		public static const MONSTER_SELECTED:String = "m_s";
		public static const MONSTER_DIE:String = "m_d";
		
		private var mChara:Character;
		
		public function CharacterEvent(type:String,chara:Character)
		{
			mChara = chara;
			super(type, false, false);
		}
		
		public function get charactor():Character
		{
			return mChara;
		}
	}
}