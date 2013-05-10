package com.physwf.components.map.piece
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.pswloader.LoadingItem;
	import com.physwf.components.pswloader.PieceItem;
	import com.physwf.components.pswloader.PswLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	public class BitmapPieceGround extends Bitmap implements IEventDispatcher, IDisposible
	{
		public static const KEY:String = "key";
		public static const COMPLETE:String = "complete";
		
		public var id:uint;
		public var focusX:uint;
		public var focusY:uint;
		private var mBitmapData:BitmapData;
		
		public function BitmapPieceGround()
		{
			super(null, "auto", false);
		}
		
		public function load():void
		{
			var pLoader:PswLoader = PswLoader.getPswLoader("key");
			var item:LoadingItem = pLoader.add("resource/map/"+id+"/key.swf",1,PswLoader.TYPE_BINARY);
			item.addEventListener(Event.COMPLETE,onKeyCompelte);
			pLoader.start();
		}
		
		private function onKeyCompelte(e:Event):void
		{
			var item:LoadingItem = e.target as LoadingItem;
			item.removeEventListener(Event.COMPLETE,onKeyCompelte);
			
			var data:ByteArray = item.getContent() as ByteArray;
			var row:uint = data.readUnsignedByte();
			var column:uint = data.readUnsignedByte();
			var size:uint = data.readUnsignedShort();
			
			mBitmapData = new BitmapData((column+1)*size,(row+1)*size,false,0x0);
			bitmapData = mBitmapData;
			
			var pLoader:PswLoader = PswLoader.getPswLoader("piece");
			var pieceItem:PieceItem;
			for(var i:uint=0;i<row;++i)
			{
				for(var j:uint =0;j<column;++j)
				{
					var priority:Number = size*size/((j*size-focusX)*(j*size-focusX) + (i*size-focusY)*(i*size-focusY));
					pieceItem = pLoader.add("resource/map/"+id+"/"+i+"_"+j,priority,PswLoader.TYPE_PIECE,".jpg") as PieceItem;
					pieceItem.x = j*size;
					pieceItem.y = i*size;
					pieceItem.addEventListener(Event.COMPLETE,onPieceComplete);
				}
			}
			pLoader.start();
			dispatchEvent(new Event(KEY));
		}
		
		private function onPieceComplete(e:Event):void
		{
			var item:PieceItem = e.target as PieceItem;
			item.removeEventListener(Event.COMPLETE,onPieceComplete);
			var bmd:BitmapData = item.getContent() as BitmapData;
			mBitmapData.copyPixels(bmd,bmd.rect,new Point(item.x ,item.y));
			item.destroy();
		}
		
		public function destroy():void
		{
			mBitmapData && mBitmapData.dispose();
			var kLoader:PswLoader = PswLoader.getPswLoader("key");
			kLoader.destroy();
			var iLoader:PswLoader = PswLoader.getPswLoader("piece");
			iLoader.destroy();
		}
	}
}