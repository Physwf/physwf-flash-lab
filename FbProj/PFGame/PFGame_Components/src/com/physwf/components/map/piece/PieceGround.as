package com.physwf.components.map.piece
{
	import com.physwf.components.pswloader.LoadingItem;
	import com.physwf.components.pswloader.PieceItem;
	import com.physwf.components.pswloader.PswLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.utils.ByteArray;

	public class PieceGround extends Bitmap implements IEventDispatcher
	{
		public static const KEY:String = "key";
		public static const COMPLETE:String = "complete";
		
		public var id:uint;
		public var focusX:uint;
		public var focusY:uint;
		
		public function PieceGround()
		{
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
			
			bitmapData && bitmapData.dispose();//to do考虑大对象的销毁
			bitmapData = new BitmapData((column+1)*size,(row+1)*size,false,0x0);
			
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
			bitmapData.copyPixels(bmd,bmd.rect,new Point(item.x ,item.y));
//			trace(item.priority,"item.priority");
//			trace(Math.abs(item.x-focusX),"item.x");
//			trace(Math.abs(item.y-focusY),"item.y");
		}
	}
}