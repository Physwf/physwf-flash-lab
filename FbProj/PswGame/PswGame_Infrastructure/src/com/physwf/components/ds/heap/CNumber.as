package com.physwf.components.ds.heap
{
	import com.physwf.components.interfaces.INumerical;

	public class CNumber implements INumerical
	{
		private var _n:Number = 0;
		public function CNumber(n:Number)
		{
			_n = n;
		}
		
		public function set value(n:Number):void
		{
			_n = n;
		}
		
		public function get value():Number
		{
			return _n;
		}
		
		public function toString():String
		{
			return int(_n) +"\n";
		}
	}
}