package display
{
	import com.adobe.images.JPGEncoder;
	import com.physwf.components.view.Animation;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.JPEGEncoder;
	import mx.graphics.codec.PNGEncoder;
	
	import shinater.swing.managers.swing_style;
	
	public class MapDisplay extends Sprite
	{
		public static var mapDir:String;
		public static var xmlDir:String;
		public static var piecesDir:String;
		
		private var mName:String;
		
		private var mGroundLayer:Sprite;
		private var mNpcLayer:Sprite;
		public function npcLayer():Sprite { return mNpcLayer; }
		private var mTeleprotLayer:Sprite;
		public function get teleportLayer():Sprite { return mTeleprotLayer; }
		
		
		private var mTeleports:Vector.<Animation>;
		private var mNpcs:Vector.<Animation>;
		
		private var mContent:Bitmap;
		
		private var rows:uint;
		private var columns:uint;
		public var size:uint=200;
		
		public function MapDisplay()
		{
			mGroundLayer = new Sprite();
			addChild(mGroundLayer);
			mNpcLayer = new Sprite();
			addChild(mNpcLayer);
			mTeleprotLayer = new Sprite();
			addChild(mTeleprotLayer);
			
			mTeleports = new Vector.<Animation>();
			mNpcs = new Vector.<Animation>();
			
			addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		
		public function load(name:String):void
		{
			mName = name;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.load(new URLRequest(mapDir+name+"/ground.jpg"));
		}
		
		private function onComplete(e:Event):void
		{
			var target:LoaderInfo = e.target as LoaderInfo;
			target.removeEventListener(Event.COMPLETE,onComplete);
			if(mContent)
			{
				mContent.parent && mContent.parent.removeChild(mContent);
				mContent.bitmapData && mContent.bitmapData.dispose();
			}
			mContent = target.loader.content as Bitmap;
			mGroundLayer.addChild(mContent);
		}
		
		public function addTeleport(tlt:TeleportDisplay):void
		{
			if(mTeleports.indexOf(tlt.sceneView)>-1) return;
			mTeleports.push(tlt.sceneView);
			mTeleprotLayer.addChild(tlt.sceneView);
		}
		
		public function addNPC(npc:NPCDisplay):void
		{
			if(mNpcs.indexOf(npc.sceneView)>-1) return ;
			mNpcs.push(npc.sceneView);
			mNpcLayer.addChild(npc.sceneView);
		}
		
		public function toPieces(option:String="jpg"):void
		{
			if(!mContent || !mContent.bitmapData) return;
			var fs:FileStream = new FileStream();
			var pngEncoder:PNGEncoder = new PNGEncoder();
			var jpgEncoder:JPGEncoder = new JPGEncoder(100);
			var pieceData:ByteArray;
			columns = Math.ceil(mContent.width / size);
			rows = Math.ceil(mContent.height / size);
			var source:BitmapData = mContent.bitmapData;
			for(var i:uint=0;i<rows;++i)
			{
				for(var j:uint=0;j<columns;++j)
				{
					var piece:BitmapData = new BitmapData(size,size,true,0);
					piece.copyPixels(source,new Rectangle(j*size,i*size,size,size),new Point());
					if(option == "jpg")
					{
						pieceData = jpgEncoder.encode(piece);
					}
					else if(option == "png")
					{
						pieceData = pngEncoder.encode(piece);
					}
					else 
					{
						pieceData = piece.getPixels(piece.rect);
						pieceData.deflate();
						option = "swf"
					}
					fs.open(new File(piecesDir+mName+"/"+i+"_"+j+"."+option),FileMode.WRITE);
					fs.writeBytes(pieceData);
					fs.close();
					trace(i,j);
				}
			}
			
			var keyData:ByteArray = new ByteArray();
			keyData.writeByte(rows);
			keyData.writeByte(columns);
			keyData.writeShort(size);
			
			fs.open(new File(piecesDir+mName+"/key.swf"),FileMode.WRITE);
			fs.writeBytes(keyData);
			fs.close();
		}
		
		public function toXML():void
		{
			var desc:XML = <desc/>;
			if(mNpcs.length)
			{
				var npcNode:XML = <npcs/>;
				for(var i:uint=0;i<mNpcs.length;++i)
				{
					var npc:XML = <npc/>;
					npc.@id = mNpcs[i].name;
					npc.@x = mNpcs[i].x;
					npc.@y = mNpcs[i].y;
					npcNode.appendChild(npc);
				}
				desc.appendChild(npcNode);
			}
			if(mTeleports.length)
			{
				var teleNode:XML = <teleports/>;
				for(i=0;i<mTeleports.length;++i)
				{
					var teleport:XML = <teleport/>;
					teleport.@x = mTeleports[i].x;
					teleport.@y = mTeleports[i].y;
					teleNode.appendChild(teleport);
				}
				desc.appendChild(teleNode);
			}
			var fs:FileStream = new FileStream();
			fs.open(new File(xmlDir+"/"+mName+".xml"),FileMode.WRITE);
			fs.writeUTFBytes(desc.toString());
			fs.close();
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			if(MapEditor.editor.dragItem)
			{
				MapEditor.editor.dragItem = null;
			}
		}
	}
}