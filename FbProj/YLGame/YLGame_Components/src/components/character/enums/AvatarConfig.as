package components.character.enums
{
	public class AvatarConfig
	{
		public static const NUDE:uint = 0;
		public static const WEAPON:uint = 1;
		public static const RIDE_FRONT:uint = 2;
		public static const RIDE_BACK:uint = 3;
		public static const WING:uint = 4;
		
		public static const direct2depths:Vector.<Vector.<uint>> = new <Vector.<uint>>
			[
						// nude weapon wing ride mask
				new <uint>[1,	2,		3,	0,		4],//up
				new <uint>[1,	2,		3,	0,		4],//right up
				new <uint>[1,	2,		3,	0,		4],//right
				new <uint>[3,	2,		1,	0,		4],//right down
				new <uint>[3,	2,		1,	0,		4],//down
				new <uint>[3,	2,		1,	0,		4],//left down
				new <uint>[1,	2,		3,	0,		4],//left
				new <uint>[1,	2,		3,	0,		4]//left up
			];
		
		public function AvatarConfig()
		{
		}
	}
}