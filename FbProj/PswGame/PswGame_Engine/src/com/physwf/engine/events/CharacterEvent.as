package com.physwf.engine.events
{
	import flash.events.Event;
	
	public class CharacterEvent extends Event
	{
//		public static const CHARA_PATH_FINISH:String = "c_p_f";//行走到路径终点
		
		public function CharacterEvent(type:String)
		{
			super(type, false, false);
		}
	}
}