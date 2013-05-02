package com.physwf.components.effects
{
	import flash.display.BitmapData;

	public class EffectFrame
	{
		public var x:int;
		public var y:int;
		public var frameData:BitmapData;
		
		public function EffectFrame(data:BitmapData=null)
		{
			frameData = data;
		}
	}
}