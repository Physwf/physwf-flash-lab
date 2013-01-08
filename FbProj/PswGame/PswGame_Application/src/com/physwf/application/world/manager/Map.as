package com.physwf.application.world.manager
{
	import com.physwf.application.world.controllers.MapController;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.MapView;
	import com.physwf.components.map.camera.Camera;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;

	public class Map implements IUpdatable
	{
		private var mMap:MapView;
		private var mCamera:Camera;
		
		private var mController:MapController;
		private var helpTarget:Sprite;
		
		public function Map()
		{
			mMap = new MapView();
			mCamera = new Camera(new Rectangle(0,0,1000,600));
			helpTarget = new Sprite();
			mCamera.target = helpTarget;
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
					mMap.fillBottom(loader.content);
				});
			loader.load(new URLRequest("resource/map/"+id+"/ground.jpg"));
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
			helpTarget.x +=5;
			mCamera.update();
		}
	}
}