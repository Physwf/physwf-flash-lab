package com.physwf.system.vo
{
	public class NPCInfo
	{
		public var id:uint;
		public var name:String;
		public var resID:uint;
		public var type:uint;//功能
		public var map_x:uint;
		public var map_y:uint;
		public var end:Vector.<uint>;
		public var path:Vector.<uint>;
	}
}