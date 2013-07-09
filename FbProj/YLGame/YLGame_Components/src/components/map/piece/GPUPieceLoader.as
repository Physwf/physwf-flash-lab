package components.map.piece
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import components.map.gpu.Environment;
	import components.map.gpu.Piece;
	import components.pswloader.File;
	import components.pswloader.PswLoader;
	import components.resource.ResourceCache;
	
	public class GPUPieceLoader extends ResourceCache
	{
		public static const KEY:String = "key";
		public static const COMPLETE:String = "complete";
		
		
		public var focusX:uint;
		public var focusY:uint;
		
		private var mUrl:String;
		
		private var mPieces:Vector.<BitmapData>;
		
		public function GPUPieceLoader(url:String)
		{
			mUrl = url;
			mPieces = new Vector.<BitmapData>();
		}
		
		public static function create(url:String):GPUPieceLoader
		{
			var loader:GPUPieceLoader = new GPUPieceLoader(url);
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
			
			var pLoader:PswLoader = PswLoader.getSamePswLoader("piece");
			var pieceItem:PieceFile;
			for(var i:uint=0;i<row;++i)
			{
				for(var j:uint =0;j<column;++j)
				{
					var priority:Number = size*size/((j*size-focusX)*(j*size-focusX) + (i*size-focusY)*(i*size-focusY));
					pieceItem = pLoader.add(mUrl+"/0"+i+"_0"+j,priority,PswLoader.TYPE_PIECE,".jpg") as PieceFile;
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
			var item:PieceFile = e.target as PieceFile;
			item.removeEventListener(Event.COMPLETE,onPieceComplete);
			var bmd:BitmapData = item.getContent() as BitmapData;
			
			var piece:Piece = new Piece(item.x,item.y,bmd.width,bmd.height);
			piece.uploadTexture(bmd);
			
			Environment.addPiece(piece);
			
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