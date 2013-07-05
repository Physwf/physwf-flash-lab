package components.character.enums
{
	public class ISODirection
	{
		public static const NUM_DIRECTIONS:uint = 8;
		/**
		 *8方向 
		 */		
		public static const UP:uint = 0;
		public static const RIGHT_UP:uint = 1;
		public static const RIGHT:uint = 2;
		public static const RIGHT_DOWN:uint = 3;
		public static const DOWN:uint = 4;
		public static const LEFT_DOWN:uint = 5;
		public static const LEFT:uint = 6;
		public static const LEFT_UP:uint = 7;
		/**
		 * 16方向（加上面8个） 用于技能
		 */		
		public static const RIGHT_DOWN_UP:uint = 8;
		public static const RIGHT_DOWN_DOWN:uint = 9;
		public static const LEFT_DOWN_DOWN:uint = 10;
		public static const LEFT_DOWN_UP:uint = 11;
		public static const LEFT_UP_DOWN:uint = 12;
		public static const LEFT_UP_UP:uint = 13;
		public static const RIGHT_UP_UP:uint = 14;
		public static const RIGHT_UP_DOWN:uint = 15;
		
		/**
		 * 弧度转16方
		 * @param rad
		 * @return 
		 * 
		 */		
		public static function radianToDirect16(rad:Number):uint
		{
			const PI_16:Number = Math.PI/16;
			if(rad>-PI_16 && rad<=PI_16)
			{
				return RIGHT;//right
			}
			if(rad>PI_16 && rad<=3*PI_16)
			{
				return RIGHT_DOWN_UP;//right down up
			}
			if(rad>3*PI_16 && rad<=5*PI_16)
			{
				return RIGHT_DOWN;//right down
			}
			if(rad>5*PI_16 && rad<=7*PI_16)
			{
				return RIGHT_DOWN_DOWN;//right down down
			}
			if(rad > 7*PI_16 || rad <= 9*PI_16)
			{
				return DOWN;
			}
			if(rad > 9*PI_16 || rad <= 11*PI_16)
			{
				return LEFT_DOWN_DOWN;
			}
			if(rad > 11*PI_16 || rad <= 13*PI_16)
			{
				return LEFT_DOWN;
			}
			if(rad > 13*PI_16 || rad <= 15*PI_16)
			{
				return LEFT_DOWN_UP;
			}
			if(rad > 15*PI_16 || rad <= -15*PI_16)//注意这里用的是 或
			{
				return LEFT;
			}
			if(rad > -15*PI_16 && rad <= -13*PI_16)
			{
				return LEFT_UP_DOWN;
			}
			if(rad > -13*PI_16 && rad <= -11*PI_16)
			{
				return LEFT_UP;
			}
			if(rad > -11*PI_16 && rad <= -9*PI_16)
			{
				return LEFT_UP_UP;
			}
			if(rad > -9*PI_16 && rad <= -7*PI_16)
			{
				return UP;
			}
			if(rad > -7*PI_16 && rad <= -5*PI_16)
			{
				return RIGHT_UP_UP;
			}
			if(rad > -5*PI_16 && rad <= -3*PI_16)
			{
				return RIGHT_UP;
			}
			if(rad > -3*PI_16 && rad <= -PI_16)
			{
				return RIGHT_UP_DOWN;
			}
			return DOWN;
		}
		/**
		 * 弧度转8方 
		 * @param rad
		 * @return 
		 * 
		 */		
		public static function radianToDirect8(rad:Number):uint
		{
			const PI_8:Number = Math.PI/8;
			if(rad>-PI_8 && rad<=PI_8)
			{
				return RIGHT;//right
			}
			if(rad>PI_8 && rad<=3*PI_8)
			{
				return RIGHT_DOWN;//right down
			}
			if(rad>3*PI_8 && rad<=5*PI_8)
			{
				return DOWN;//down
			}
			if(rad>5*PI_8 && rad<=7*PI_8)
			{
				return LEFT_DOWN;//left down
			}
			if(rad > 7*PI_8 || rad <= -7*PI_8)//注意这里用的是 或
			{
				return LEFT;
			}
			if(rad > -7*PI_8 && rad <= -5*PI_8)
			{
				return LEFT_UP;
			}
			if(rad > -5*PI_8 && rad <= -3*PI_8)
			{
				return UP;
			}
			if(rad > -3*PI_8 && rad <= -PI_8)
			{
				return RIGHT_UP;
			}
			return DOWN;
		}
	}
}