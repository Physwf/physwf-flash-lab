package engine.world.objects
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.Timer;
	
	import components.interfaces.IUpdatable;
	import components.map.MapView;
	import components.map.camera.Camera;
	import components.map.piece.PieceGroundLoader;
	import components.map.wayfinding.astar.BiHeapAstar;
	import components.map.wayfinding.astar.ISOCoordUtils;
	import components.pswloader.BinaryFile;
	import components.pswloader.PswLoader;
	import components.utils.BitArray;
	import components.utils.ByteHelper;
	
	import engine.Engine;
	import engine.world.controllers.MapController;
	
	public class Map extends EventDispatcher implements IUpdatable
	{
		public var id:uint;
		
		private var mMapView:MapView;
		private var mCamera:Camera;
		
		private var mCharactors:Vector.<Character>;
		
		private var mController:MapController;
		
		public function Map()
		{
			mMapView = new MapView();
			mCamera = new Camera(new Rectangle(0,0,1920,1080));
			
			Engine.map = this;
			
			mCharactors = new Vector.<Character>();
			
			Character.self = new Character();
			Character.self.view.x = 500;
			Character.self.view.y = 700;
			mCamera.target = Character.self.view;
			mCamera.initialize(mMapView);
			addCharacter(Character.self);
			
			var t:Timer = new Timer(20,200);
			t.addEventListener(TimerEvent.TIMER,function(e:Event):void
			{
				var c:Character = new Character();
				//					c.view.x = mMapView.width * Math.random();
				//					c.view.y = mMapView.height * Math.random();
				addCharacter(c);
			});
			t.start();
			
//			for(var i:uint=0;i<300;i++)
//			{
//				var c:Character = new Character();
//				c.view.x = 5120* Math.random();
//				c.view.y = 5120* Math.random();
//				//					c.view.x = mMapView.width * Math.random();
//				//					c.view.y = mMapView.height * Math.random();
//				addCharacter(c);
//			}
			
			
		}
		
		
		public function initialize():void
		{
			mController = new MapController();
			mController.initialize(mMapView);
		}
		
		public function load():void
		{
			var pLoader:PswLoader = PswLoader.getSamePswLoader("map",PswLoader.MODE_MANU,true);
			pLoader.add("cdn/assets/maps/"+id+".map",1,PswLoader.TYPE_BINARY) as BinaryFile;
			pLoader.add("cdn/assets/maps/"+id+".nav",1,PswLoader.TYPE_BINARY) as BinaryFile;
//			pLoader.add("cdn/assets/maps"+id+".zone",1,PswLoader.TYPE_BINARY) as BinaryFile;
//			pLoader.add("cdn/assets/maps"+id+".cover",1,PswLoader.TYPE_BINARY) as BinaryFile;
//			pLoader.add("cdn/assets/maps"+id+".npc",1,PswLoader.TYPE_BINARY) as BinaryFile;
			pLoader.addEventListener(Event.COMPLETE,onComplete);
			pLoader.start();
		}
		
		private function onComplete(e:Event):void
		{
			var pLoader:PswLoader = PswLoader.getSamePswLoader("map",PswLoader.MODE_MANU,true);
			pLoader.removeEventListener(Event.COMPLETE,onComplete);
			var mapData:ByteArray = pLoader.getBinary("cdn/assets/maps/"+id+".map");
			var navData:ByteArray = pLoader.getBinary("cdn/assets/maps/"+id+".nav");
//			var zoneData:ByteArray = pLoader.getBinary("cdn/assets/maps"+id+".zone");
//			var coverData:ByteArray = pLoader.getBinary("cdn/assets/maps"+id+".cover");
//			var npcData:ByteArray = pLoader.getBinary("cdn/assets/maps"+id+".npc");
			
			parseMapFile(mapData);
			parseNavFile(navData);
		}
		
		private var gridColum:uint;
		private var gridRow:uint;
		private function parseMapFile(data:ByteArray):void
		{
			data.endian = Endian.LITTLE_ENDIAN;
			var header:ByteArray = new ByteArray();
			var version:ByteArray = new ByteArray();
			data.readBytes(header, 0, 4);
			data.readBytes(version, 0, 2);
			var w:int = data.readInt();
			var h:int = data.readInt();
			var tileW:int = data.readInt();
			var tileH:int = data.readInt();
			var numTilesW:int = int((w + tileW - 1) / tileW);
			var numTilesH:int = int((h + tileH - 1) / tileH);
			
			if (version[0] >= 4) 
			{
				data.readUnsignedInt();
			}
			
			var numNames:uint = data.readUnsignedInt();
			var names:Vector.<String> = new Vector.<String>();
			for(var i:uint=0;i<numNames;++i)
			{
				names.push(ByteHelper.readString(data));
			}
			for(i=0;i<3;++i)
			{
				var numEntities:uint = data.readUnsignedInt();
				for(var j:uint=0;j<numEntities;++j)
				{
					var index:uint = data.readUnsignedShort();
					var speed:uint = data.readUnsignedShort();
					
					var s:String = names[index];
					var x:Number = data.readFloat();
					var y:Number = data.readFloat();
				}
			}
			
			ISOCoordUtils.size = data.readUnsignedInt();
			gridColum = data.readUnsignedInt();
			gridRow = data.readUnsignedInt();
			ISOCoordUtils.angle = data.readUnsignedInt();
			ISOCoordUtils.offsetX = data.readInt();
			ISOCoordUtils.offsetY = data.readInt();
		}
		
		private var navData:Vector.<uint>;
		private function parseNavFile(data:ByteArray):void
		{
			data.endian = Endian.LITTLE_ENDIAN;
			navData = new Vector.<uint>(gridRow * gridColum,true);
			for(var i:uint=0;i<gridColum;i++)
			{
				var block:uint = data.readUnsignedByte();
				var mask:BitArray = new BitArray();
				mask.length = block * 4;
				
				data.readBytes(mask,0,mask.length);
				for (var j:uint=0;j<gridRow;j++) 
				{
					if (mask.getBit(j)) 
					{
						navData[j*gridColum+i] = data.readUnsignedByte();	
					}							
				}
			}
			var astar:BiHeapAstar = new BiHeapAstar(mMapView);
			astar.analyze(navData,gridColum,gridRow);
			Character.astar = astar;
			
			var pgLoader:PieceGroundLoader = PieceGroundLoader.create("cdn_n/assets/maps/"+id,mMapView.bottom);;
			pgLoader.focusX = Character.self.view.x;
			pgLoader.focusY = Character.self.view.y;
			pgLoader.addEventListener(PieceGroundLoader.KEY,function (e:Event):void 
			{
				mCamera.moveToTarget();
			});
			pgLoader.load();
		}
		
		public function addCharacter(chara:Character):void
		{
			trace("add character:"+mCharactors.length);
			mCharactors.push(chara);
			mMapView.addElement(chara.view);
		}
		
		public function update(delta:uint):void
		{
			mMapView.rebuild();
			for(var i:int=0;i<mCharactors.length;++i)
			{
				if(Engine.map.camera.viewprot.contains(mCharactors[i].view.x,mCharactors[i].view.y))
				{
					mCharactors[i].view.cull = false;
					mMapView.addSwapElement(mCharactors[i].view);
				}
				else
				{
					mCharactors[i].view.cull = true;
				}
				mCharactors[i].update(delta);
			}
			mMapView.update(delta);
			mCamera.update();
		}
		
		
		public function get view():MapView { return mMapView; }
		public function get camera():Camera { return mCamera; }
	}
}