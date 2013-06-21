package components.character.enum
{
	public class CharacterAction
	{
		public static const ACTION_IDLE:uint = 0;
		public static const ACTION_RUN:uint = 1;
		public static const ACTION_SIT:uint = 2;
		public static const ACTION_ATTACK0:uint = 3;
		public static const ACTION_ATTACK1:uint = 4;
		public static const ACTION_DEATH:uint = 5;
		public static const ACTION_RIDE_IDLE:uint = 6;
		public static const ACTION_RIDE_RUN:uint = 7;
		
		public static const DIC:Vector.<String> = 
			Vector.<String>(["idle","run","sit","atk01","atk02","death","ride_idle","ride_run"]);
		
		
		public static function idToName(id:uint):String
		{
			return DIC[id];
		}
		
		public static function nameToId(name:String):uint
		{
			return DIC.indexOf(name)
		}
	}
}