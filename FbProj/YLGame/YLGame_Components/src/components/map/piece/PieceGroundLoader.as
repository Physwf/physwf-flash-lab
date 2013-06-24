package components.map.piece
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import components.pswloader.File;
	import components.pswloader.PswLoader;
	import components.resource.ResourceCache;
	
	public class PieceGroundLoader extends ResourceCache
	{
		public static const KEY:String = "key";
		public static const COMPLETE:String = "complete";
		
		private var mGround:Sprite;
		
		public var focusX:uint;
		public var focusY:uint;
		
		private var mUrl:String;
		
		private var mPieces:Vector.<BitmapData>;
		
		public function PieceGroundLoader(url:String,ground:Sprite)
		{
			mUrl = url;
			mGround = ground;
			mPieces = new Vector.<BitmapData>();
		}
		
		public static function create(url:String,ground:Sprite):PieceGroundLoader
		{
			var loader:PieceGroundLoader = new PieceGroundLoader(url,ground);
			loader.incRefCount();
			return loader;
		}
		
		public function load():void
		{
			var pLoader:PswLoader = PswLoader.getSamePswLoader("key");
			var item:File = pLoader.add(mUrl+"/key.swf",1,PswLoader.TYPE_BINARY);
			item.addEventListener(Event.COMPLETE,onKeyCompelte);
		}
		
		private function onKeyCompelte(e:Event):void
		{
			var item:File = e.target as File;
			item.removeEventListener(Event.COMPLETE,onKeyCompelte);
			
			var data:ByteArray = item.getContent() as ByteArray;
			var row:uint = data.readUnsignedByte();
			var column:uint = data.readUnsignedByte();
			var size:uint = data.readUnsignedShort();
			
			mGround.graphics.clear();
			mGround.graphics.beginFill(0,0);
			mGround.graphics.drawRect(0,0,(column+1)*size,(row+1)*size);
			mGround.graphics.endFill();
			
			var pLoader:PswLoader = PswLoader.getSamePswLoader("piece");
			var pieceItem:MapPiece;
			for(var i:uint=0;i<row;++i)
			{
				for(var j:uint =0;j<column;++j)
				{
					var priority:Number = size*size/((j*size-focusX)*(j*size-focusX) + (i*size-focusY)*(i*size-focusY));
					pieceItem = pLoader.add(mUrl+"/0"+i+"_0"+j,priority,PswLoader.TYPE_PIECE,".jpg") as MapPiece;
					pieceItem.x = i*size;
					pieceItem.y = j*size;
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
			
			mGround.addChild(bitmap);
			
			mPieces.push(bmd);
			
//			var kLoader:PswLoader = PswLoader.getSamePswLoader("key");
//			kLoader.destroy();
//			var iLoader:PswLoader = PswLoader.getSamePswLoader("piece");
//			iLoader.destroy();
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