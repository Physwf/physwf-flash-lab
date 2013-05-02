package com.physwf.components.map.wayfinding.astar
{
	import com.physwf.components.interfaces.INumerical;
	/**
	 * 寻路节点 
	 * @author joe
	 * 
	 */
	public class Node implements INumerical
	{
		public var x:Number;
		public var y:Number;
		
		private var _f:Number=0;
		public var g:Number=0;
		public var h:Number=0;
		
		public var walkable:Boolean = false;
		public var costMultiply:Number;
		
		public var parent:Node;
		/**
		 *节点类型，即地形，配置为颜色值，不同颜色代表不同地形 .
		 * 取值为NodeType中的枚举常量
		 */		
		private var _type:uint;
		
		public function Node(x:int,y:int)
		{
			this.x = x;
			this.y = y;
		}
		
		public function set f(v:Number):void
		{
			_f = v;
		}
		
		public function get f():Number
		{
			return _f;
		}
		
		public function get value():Number
		{
			return _f;
		}
		
		public function set type(v:uint):void
		{
			if(_type == v) return;
			_type = v;
			costMultiply = NodeType.typeToCost(_type);
			if(_type != 0) walkable = true;
		}
		
		public function get type():uint
		{
			return _type;
		}
		
		public function toString():String
		{
			return String("["+x+","+y+"]");
		}
		
	}
}