package camera
{
	import com.physwf.components.map.IMap;
	import com.physwf.components.map.TileBasedMap;
	import com.physwf.components.map.camera.ICamera;
	import com.physwf.components.map.camera.IScreen;
	import com.physwf.components.map.camera.ScreenBase;
	
	import flash.display.DisplayObject;
	
	public class Camera implements ICamera
	{
		private var _map:IMap;
		private var _screen:IScreen;
		
		private var _speed:Number=1;
		private var _direction:Number=0;
		
		public function Camera()
		{
		}
		
		public function initialize(map:IMap):void
		{
			_screen = new ScreenBase();
			_map = map;
			_map.screen = _screen;
		}
		
		public function set target(obj:DisplayObject):void
		{
		}
		
		public function get screen():IScreen
		{
			return _screen;
		}
		
		public function moveTo(x:Number, y:Number, useTween:Boolean):void
		{
		}
		
		public function shake():void
		{
		}
		
		public function update():void
		{
			_screen.rect.x += _speed * Math.cos(_direction);
			_screen.rect.y += _speed * Math.sin(_direction);
			_map.update();
		}
	}
}