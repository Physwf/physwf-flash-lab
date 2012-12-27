package com.physwf.components.utils
{
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
	}
}