package com.physwf.components.map.tile
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	public class TileStruct  
	{
		public static var HEIGHT:uint = 32;//单位像素尺寸
		public static var WIDTH:uint = 64;
		/**
		 *每个◇区块宽高比为2:1,以高的尺寸为单位1 
		 */		
		public var x:Number;
		public var y:Number;
		public var resID:uint;
		
		public function TileStruct($x:uint,$y:uint,$resID:uint)
		{
			x = $x*WIDTH;
			y = ($y-1)*HEIGHT*.5;
			if($y%2!=0) x -= (WIDTH*.5);
			resID = $resID;
		}
	}
}