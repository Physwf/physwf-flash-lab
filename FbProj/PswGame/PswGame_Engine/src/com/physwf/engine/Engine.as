package com.physwf.engine
{
	import com.physwf.engine.bag.Bag;
	import com.physwf.engine.frame.Frame;
	import com.physwf.engine.world.World;
	import com.physwf.engine.world.manager.Map;

	public class Engine
	{
		public static var world:World;
		public static var map:Map;
		public static var frame:Frame;
		public static var bag:Bag;
		
		public function Engine()
		{
		}
	}
}