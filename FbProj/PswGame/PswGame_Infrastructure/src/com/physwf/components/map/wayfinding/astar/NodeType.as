package com.physwf.components.map.wayfinding.astar
{
	public class NodeType
	{
		public static const TYPE_LAND:uint = 0x77804000;//brown
		public static const TYPE_WATER:uint = 0x770066CC;// blue
		public static const TYPE_ICE:uint = 0x77E7E7E7;// silver
		public static const TYPE_GRASS:uint = 0x7700C400;//green
		
		public static const COST_LAND:Number = 1;
		public static const COST_WATER:Number = 2;
		public static const COST_ICE:Number = 1.5;
		public static const COST_GRASS:Number = 1.2;
		
		public function NodeType()
		{
		}
		
		public static function typeToCost(type:uint):Number
		{
			switch(type)
			{
				case TYPE_LAND:
					return COST_LAND;
					break;
				case TYPE_WATER:
					return COST_WATER;
					break;
				case TYPE_ICE:
					return COST_ICE;
					break;
				case TYPE_GRASS:
					return COST_GRASS;
					break;
			}
			return 0;
		}
	}
}