package
{
	import com.physwf.components.map.IMap;
	import com.physwf.components.map.MapBase;
	import com.physwf.components.map.camera.ICamera;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import camera.Camera;
	
	[SWF(width="1200",height="800")]
	public class PswGame_Demo_map extends Sprite
	{
		private var _camera:ICamera;
		private var _map:IMap;
		public function PswGame_Demo_map()
		{
			init();
		}
		
		private function init():void
		{
			_map = new MapBase();
			_camera = new Camera();
			_camera.initialize(_map);
			_map.initialize();
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
			addChild(_map.display);
			var bitmapData:BitmapData = new BitmapData(1200,800,true,0xFFFFFFFF);
			bitmapData.fillRect(new Rectangle(100,100,960,560),0x00);
			addChild(new Bitmap(bitmapData));
		}
		
		private function onEnterFrame(e:Event):void
		{
			var timer:Number = getTimer();
			_camera.update();
			trace(getTimer()-timer)
		}
	}
}