package com.physwf.system.events
{
	import com.physwf.system.vo.FightInfo;
	
	import flash.events.Event;
	
	public class FightEvent extends Event
	{
		public static const FIGHT_RESULT:String = "f_r";
		public static const FIGHT_DEATH:String = "f_d";
		
		private var mInfos:Vector.<FightInfo>;
		
		public function FightEvent(type:String,infos:Vector.<FightInfo>)
		{
			super(type, false, false);
			mInfos = infos;
		}
		
		public function get infos():Vector.<FightInfo>
		{
			return mInfos;
		}
	}
}