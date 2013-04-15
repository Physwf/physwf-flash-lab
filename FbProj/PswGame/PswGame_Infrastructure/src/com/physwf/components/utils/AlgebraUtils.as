package com.physwf.components.utils
{
	import flash.geom.Point;
	
	import mx.messaging.AbstractConsumer;

	public class AlgebraUtils
	{
		public function AlgebraUtils()
		{
		}
		
		public static function getNextPower(input:Number):Number
		{
			if(input<0) throw "输入值必须大于零！";
			var i:int = Math.sqrt(input);
			if(input>i*i)
			{
				i++;
			}
			return i;
		}
		/**
		 * 弧度转换成坐标，用在cd动画中。 
		 * @return 
		 * 
		 */		
		public static function radToCoord(rad:Number):Point
		{
			if(rad > Math.PI * 1.75 && rad <= Math.PI * 2)
			{
				return new Point(-Math.tan(Math.PI * 2 - rad),-1);
			}
			else if(rad > 0 && rad < Math.PI * .25)
			{
				return new Point(Math.tan(rad),-1);
			}
			else if(rad >= Math.PI * .25 && rad<Math.PI * .5)
			{
				return new Point(1,-1/Math.tan(rad));
			}
			else if(rad >= Math.PI * .5 && rad < Math.PI * .75)
			{
				return new Point(1,Math.tan(rad - Math.PI * .5));
			}
			else if(rad >= Math.PI * .75 && rad < Math.PI)
			{
				return new Point(Math.tan(Math.PI - rad),1);
			}
			else if(rad >= Math.PI && rad < Math.PI * 1.25)
			{
				return new Point(-Math.tan(rad -Math.PI),1);
			}
			else if(rad >= Math.PI * 1.25 && rad < Math.PI * 1.5)
			{
				return new Point(-1, Math.tan(Math.PI * 1.5 - rad));
			}
			else(rad >= Math.PI * 1.5 && rad < Math.PI * 1.75)
			{
				return new Point(-1,-Math.tan(rad - Math.PI*1.5));
			}
		}
	}
}