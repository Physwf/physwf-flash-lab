package com.physwf.components.map.wayfinding.astar
{
	import com.physwf.components.map.data.GridTypeMapData;

	/**
	 * 寻路用到的线段，连接相邻两个节点间的 
	 * @author joe
	 * 
	 */	
	public class Line
	{
		private var _sx:Number;
		private var _sy:Number;
		private var _ex:uint;
		private var _ey:uint;
		
		private var _length:Number;
		private var _lenInvalide:Boolean = true;
		private var _direcRad:Number;
		
		public function Line(preNode:Node,nextNode:Node)
		{
			_sx = preNode.x * GridTypeMapData.GRID_SIZE;
			_sy = preNode.y * GridTypeMapData.GRID_SIZE;
			_ex = nextNode.x * GridTypeMapData.GRID_SIZE;
			_ey = nextNode.y * GridTypeMapData.GRID_SIZE;
			if(_sx == _ex || _sy == _ey) _length = GridTypeMapData.GRID_SIZE;
			else _length = GridTypeMapData.GRID_SIZE * Math.SQRT2;
			_direcRad = Math.atan2(_ey - _sy,_ex - _sx);//有八个可能值
		}
		
		public function get sx():Number
		{
			return _sx;
		}
		
		public function set sx(value:Number):void
		{
			_sx = value;
			_lenInvalide = true;
		}
		
		public function get sy():Number
		{
			return _sy;
		}

		public function set sy(value:Number):void
		{
			_sy = value;
			_lenInvalide = true;
		}
		
		public function get ex():uint
		{
			return _ex;
		}

		public function get ey():uint
		{
			return _ey;
		}
		/**
		 * 在原有长度基础之上减去一定值，该方法会导致起点发生变化，但不会影响终点 
		 * @param value
		 * 
		 */
		public function subLen(value:Number):void
		{
			if(value>_length || value<0) throw "参数不合法，必须小于原有长度！";
			_length -= value;
			_sx += value * Math.cos(_direcRad);
			_sy += value * Math.sin(_direcRad);
		}
		
		public function get length():Number
		{
			if(_lenInvalide)
			{
				if(_sx == _ex)
				{
					_length = Math.abs(_ey - _sy);
				}
				else if(_sy == _ey)
				{
					_length = Math.abs(_ex - _sx);
				}
				else
				{
					var weightX:Number = _ex - _sx;
					var weightY:Number = _ey - _sy;
					_length = Math.sqrt(weightX*weightX+weightY*weightY);
				}
				_lenInvalide = false;
			}
			return _length;
		}

		public function get directRad():Number
		{
			return _direcRad;
		}
		
		public function toString():String
		{
			return "[sx:"+_sx+",sy:"+_sy+",ex:"+_ex+",ey:"+_ey+",length:"+length+",direct:"+_direcRad+"]";
		}
	}
}