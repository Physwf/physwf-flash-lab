package com.physwf.components.charactor.enum
{
	public class ISODirection
	{
		public static const NUM_DIRECTIONS:uint = 8;
		
		public static const RIGHT:uint = 0;
		public static const RIGHT_DOWN:uint = 1;
		public static const DOWN:uint = 2;
		public static const LEFT_DOWN:uint = 3;
		public static const LEFT:uint = 4;
		public static const LEFT_UP:uint = 5;
		public static const UP:uint = 6;
		public static const RIGHT_UP:uint = 7;
		
		public static function radianToDirect(rad:Number):uint
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