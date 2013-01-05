package com.physwf.application.game.layer
{
	import com.physwf.application.game.controllers.MapController;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.Map;
	import com.physwf.components.map.camera.Camera;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;

	public class MapLayer implements IUpdatable
	{
		private var mMap:Map;
		private var mCamera:Camera;
		
		private var mController:MapController;
		
		public function MapLayer()
		{
			mMap = new Map();
			mCamera = new Camera(new Rectangle(0,0,1000,600));
			mCamera.initialize(mMap);
			mController = new MapController();
		}
		
		public function load():void
		{
			var id:uint = mController.getMapID();
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(
				Event.COMPLETE,
				function (e:Event):void 
				{
					mMap.mapWidth = loader.content.width;
					mMap.mapHeight = loader.content.height;
					mMap.bottom.addChild(loader.content);
				});
			loader.load(new URLRequest("resouce/map/"+id+".png"));
		}
		
		public function attachLayer(game:Sprite):void
		{
			game.addChild(mMap);
		}
		
		public function detachLayer():void
		{
			mMap.parent && mMap.removeChild(mMap);
		}
		
		public function update():void
		{
			mCamera.update();
		}
	}
}