package
{
	import com.physwf.common.interfaces.ITool;
	import com.physwf.components.view.Animation;
	
	import components.MainMenu;
	
	import display.MapDisplay;
	import display.NPCDisplay;
	import display.ObjectDisplay;
	import display.TeleportDisplay;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.ByteArray;
	
	import mx.core.FontAsset;
	
	import spark.components.Application;
	import spark.components.Window;
	
	public class MapEditor implements ITool
	{
		public static var editor:MapEditor;
		
		private var mMainMenu:MainMenu;
		
		private var mMapLayer:Sprite;
		private var mUiLayer:Sprite;
		public function get uiLayer():Sprite { return mUiLayer; }
		
		private var mMapDisplay:MapDisplay;
		public function get map():MapDisplay { return mMapDisplay; }
		private var isSpacePressed:Boolean;
		
		public var dragItem:Animation;
		private var DIR_DOCUMENT:String;
		private var win:Window
		private var stage:Stage;
		
		private var configFile:File;
		
		public function MapEditor()
		{
			FontAsset;
		}
		
		public function execute(root:Application):void
		{
			init();
		}
		
		public function exit():void
		{
			win.close();
		}
		
		private function init():void
		{
			editor = this;
			win = new Window();
			win.open();
			stage = win.stage;
			win.maximize();
			
			if(stage == null)
			{
				trace(stage)
				return;
			}
			stage.addEventListener(Event.RESIZE,onStageResize);
			
			mUiLayer = new Sprite();
			
			mMainMenu = new MainMenu(stage);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			
			mMapDisplay = new MapDisplay();
			
			mMapDisplay.addEventListener(MouseEvent.MOUSE_DOWN,onMapDisplayPress);
			mMapDisplay.addEventListener(MouseEvent.MOUSE_UP,onMapDisplayRelease);
			
			stage.addChild(mMapDisplay);
			stage.addChild(mUiLayer);
			
			stage.root.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			
			var file:File = new File(File.applicationDirectory.nativePath);
			var assetsDir:File = file.resolvePath("../assets/MapEditor/");
			configFile = assetsDir.resolvePath("config/project.xml");
			configFile.addEventListener(Event.COMPLETE,onConfigComplete);
			configFile.load();
		}
		
		private function onConfigComplete(e:Event):void
		{
			var target:File = e.target as File;
			target.removeEventListener(Event.COMPLETE,onConfigComplete);
			var data:ByteArray = e.target.data as ByteArray;
			
			var config:XML = XML(data.readUTFBytes(data.bytesAvailable));
			
			DIR_DOCUMENT = config.@document;
			config = XML(String(config).replace(/%DOCUMENT%/g,DIR_DOCUMENT));
			
			var read:XML = config.read[0];
			var write:XML = config.write[0];
			
			MapDisplay.mapDir = (read.map[0]).@dir;
			MapDisplay.xmlDir = write.xml[0].@dir;
			MapDisplay.piecesDir = write.piece[0].@dir;
			
			TeleportDisplay.IconDir = read.@iconDir+read.teleport[0].@icon;
			TeleportDisplay.SceneDir = read.teleport[0].@dir;
			
			NPCDisplay.IconDir =  read.@iconDir+read.npc[0].@icon;
			NPCDisplay.SceneDir = read.npc[0].@dir;
			
			getTeleportList();
		}
		
		private function getTeleportList():void
		{
			var file:File = new File(TeleportDisplay.IconDir);
			var list:Array = file.getDirectoryListing();
			for each(file in list)
			{
				var item:TeleportDisplay = new TeleportDisplay(file.name);
				item.load();
				mMainMenu.teleportBox.pushItem(item);
			}
		}
		
		public function generate(option:String="jpg"):void
		{
			mMapDisplay.toPieces(option);
//			mMapDisplay.toXML();
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.SPACE:
					Mouse.cursor = MouseCursor.HAND;
					Mouse.show();//为了让鼠标上一行代码立即有效，需要调用show()一次
					isSpacePressed = true;
					break;
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.SPACE:
					Mouse.cursor = MouseCursor.AUTO;
					Mouse.show();//为了让鼠标上一行代码立即有效，需要调用show()一次
					isSpacePressed = false;
					break;
			}
		}
		
		private function onMapDisplayPress(e:MouseEvent):void
		{
			if(isSpacePressed)
			{
				mMapDisplay.startDrag(false,new Rectangle(0,0,-mMapDisplay.width+stage.stageWidth,-mMapDisplay.height+stage.stageHeight));
			}
		}
		private function onMapDisplayRelease(e:MouseEvent):void
		{
			mMapDisplay.stopDrag();
		}
		
		private function onStageResize(e:Event):void
		{
			mMainMenu.onStageResize();
		}
		
		private function onEnterFrame(e:Event):void
		{
			if(dragItem)
			{
				dragItem.x = mMapDisplay.mouseX;
				dragItem.y = mMapDisplay.mouseY;
			}
			for each(var ani:Animation in ObjectDisplay.animations)
			{
				ani.update();
			}
		}
	}
}