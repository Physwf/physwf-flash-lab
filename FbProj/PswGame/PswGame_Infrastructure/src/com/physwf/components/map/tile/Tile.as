package com.physwf.components.map.tile
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class Tile extends Bitmap
	{
		private var mStruct:TileStruct;
		
		public function Tile(struct:TileStruct)
		{
			mStruct = struct;
			x = mStruct.x ;
			y = mStruct.y ;
			super(null,"auto", false);
		}
		
		public function get info():TileStruct
		{
			return mStruct;
		}
	}
}