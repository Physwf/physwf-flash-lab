package com.physwf.components.map.piece
{
	import com.physwf.components.pswloader.File;
	import com.physwf.components.pswloader.PswLoader;
	import com.physwf.components.resource.ResourceCache;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	public class PieceGroundLoader extends ResourceCache
	{
		public static const KEY:String = "key";
		public static const COMPLETE:String = "complete";
		
		public var content:Sprite;
		
		public var focusX:uint;
		public var focusY:uint;
		
		private var mUrl:String;
		
		private var mPieces:Vector.<BitmapData>;
		
		public function PieceGroundLoader(url:String)
		{
			mUrl = url;
			content = new Sprite();
			content.mouseEnabled = false;
			content.mouseChildren = false;
			mPieces = new Vector.<BitmapData>();
		}
		
		public static function create(url:String):PieceGroundLoader
		{
			var loader:PieceGroundLoader = new PieceGroundLoader(url);
			loader.incRefCount();
			return loader;
		}
		
		public function load():void
		{
			var pLoader:PswLoader = PswLoader.getPswLoader("key");
			var item:File = pLoader.add(mUrl+"/key.swf",1,PswLoader.TYPE_BINARY);
			item.addEventListener(Event.COMPLETE,onKeyCompelte);
			pLoader.start();
		}
		
		private function onKeyCompelte(e:Event):void
		{
			var item:File = e.target as File;
			item.removeEventListener(Event.COMPLETE,onKeyCompelte);
			
			var data:ByteArray = item.getContent() as ByteArray;
			var row:uint = data.readUnsignedByte();
			var column:uint = data.readUnsignedByte();
			var size:uint = data.readUnsignedShort();
			
			content.graphics.beginFill(0,0);
			content.graphics.drawRect(0,0,(column+1)*size,(row+1)*size);
			content.graphics.endFill();
			
			var pLoader:PswLoader = PswLoader.getPswLoader("piece");
			var pieceItem:MapPiece;
			for(var i:uint=0;i<row;++i)
			{
				for(var j:uint =0;j<column;++j)
				{
					var priority:Number = size*size/((j*size-focusX)*(j*size-focusX) + (i*size-focusY)*(i*size-focusY));
					pieceItem = pLoader.add(mUrl+i+"_"+j,priority,PswLoader.TYPE_PIECE,".jpg") as MapPiece;
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
			var item:MapPiece = e.target as MapPiece;
			item.removeEventListener(Event.COMPLETE,onPieceComplete);
			var bmd:BitmapData = item.getContent() as BitmapData;
			var bitmap:Bitmap = new Bitmap(bmd);
			bitmap.x = item.x;
			bitmap.y = item.y;
			
			Sprite(content).addChild(bitmap);
			
			mPieces.push(bmd);
			
			var kLoader:PswLoader = PswLoader.getPswLoader("key");
			kLoader.destroy();
			var iLoader:PswLoader = PswLoader.getPswLoader("piece");
			iLoader.destroy();
		}
		
		override public function destroy():void
		{
			var begin:uint = getTimer();
			while(mPieces.length)
			{
				if(getTimer() - begin >= 3) break;//如果超过3毫秒则退出，等待其他空闲帧在继续
				var piece:BitmapData = mPieces.shift();
				piece.dispose();
			}
		}
		
		override public function get isDestroied():Boolean
		{
			return (mPieces.length == 0);
		}
	}
}