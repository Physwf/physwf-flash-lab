package com.physwf.components.map.tile
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	public class TileGround extends Sprite
	{
		private var mTiles:Vector.<Tile>;
		private var mResList:Vector.<BitmapData>;
		
		public function TileGround()
		{
			super();
			graphics.beginFill(0x1234567);
			graphics.drawRect(0,0,1000,600);
			graphics.endFill();
		}
		
		public function load(request:URLRequest):void
		{
			var stream:URLStream = new URLStream();
			stream.addEventListener(Event.COMPLETE,onComplete);
			stream.load(request);
		}
		
		private function onComplete(e:Event):void
		{
			var stream:URLStream = e.target as URLStream;
			stream.removeEventListener(Event.COMPLETE,onComplete);
			readData(stream);
		}
		
		private function readData(stream:URLStream):void
		{
			//读取素材
			var numRes:uint = stream.readShort();
			mResList = new Vector.<BitmapData>(numRes,true);
			var helpRect:Rectangle = new Rectangle(0,0,TileStruct.WIDTH,TileStruct.HEIGHT);
			for(var i:int=0;i<numRes;++i)
			{
				var bytesLen:uint = stream.readShort();
				var bytes:ByteArray = new ByteArray();
				stream.readBytes(bytes,0,bytesLen);
				var bmd:BitmapData = new BitmapData(helpRect.width,helpRect.height,true,0xFFFF0000);
				bmd.setPixels(helpRect,bytes);
				mResList[i] = bmd;
			}
			//读取区块信息
			var numTiles:uint = stream.readShort();
			mTiles = new Vector.<Tile>(numTiles,true);
			for(i=0;i<numTiles;++i)
			{
				var $x:uint = stream.readShort();
				var $y:uint = stream.readShort();
				var $resID:uint = stream.readShort();
				var struct:TileStruct = new TileStruct($x,$y,$resID);
				var tile:Tile = new Tile(struct);
				mTiles[i] = tile;
				mTiles[i].bitmapData = mResList[struct.resID];
				addChild(tile);
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}