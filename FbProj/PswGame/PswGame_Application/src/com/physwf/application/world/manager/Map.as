package com.physwf.application.world.manager
{
	import com.physwf.application.world.controllers.MapController;
	import com.physwf.application.world.events.WorldEvent;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.MapView;
	import com.physwf.components.map.camera.Camera;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.events.MapEvent;
	import com.physwf.system.events.MyEvent;
	import com.physwf.system.vo.UserInfo;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;

	public class Map extends EventDispatcher implements IUpdatable
	{
		private var mMapView:MapView;
		private var mCamera:Camera;
		
		private var mController:MapController;
		
		private var mCharactors:Vector.<Charactor>;
		
		public function Map()
		{
			mMapView = new MapView();
			mCamera = new Camera(new Rectangle(0,0,1000,600));
			
			Charactor.self = new Charactor();
			Charactor.self.initialize(MySelf.userInfo);
			
			mCharactors = new <Charactor>[];
			addCharactor(Charactor.self);
			
			mCamera.target = Charactor.self.view;
			mCamera.initialize(mMapView);
			
			mController = new MapController();
			mController.initialize(mMapView);
		}
		
		public function initialize():void
		{
			System.map.addEventListener(MapEvent.MAP_USER_LIST_SUCCESS,onMapEvent);
			System.map.addEventListener(MapEvent.MAP_USER_MOVE,onMapEvent);
			System.myself.addEventListener(MyEvent.ENTER_MAP_SUCCESS,onMyEvent);
		}
		
		private function onMapEvent(e:MapEvent):void
		{
			switch(e.type)
			{
				case MapEvent.MAP_USER_ENTER_MAP:
					break;
				case MapEvent.MAP_USER_LEAVE_MAP:
					break;
				case MapEvent.MAP_USER_LIST_DETAIL_SUCCESS:
					break;
				case MapEvent.MAP_USER_LIST_SUCCESS:
					var mapUserList:Vector.<UserInfo> = System.map.mapUserList;
					for(var i:int=0;mapUserList.length;i++)
					{
						var chara:Charactor = new Charactor();
						chara.initialize(mapUserList[i]);
						addCharactor(chara);
					}
					break;
				case MapEvent.MAP_USER_MOVE:
					// to do 根据userInfo找到相应的character，然后设置该character到指定点
					break;
			}
		}
		
		private function onMyEvent(e:MyEvent):void
		{
			switch(e.type)
			{
				case MyEvent.ENTER_MAP_SUCCESS:
					
					break;
			}
		}
		
		public function load():void
		{
			var id:uint = mController.getMapID();
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(
				Event.COMPLETE,
				function (e:Event):void 
				{
					mMapView.fillBottom(loader.content);
				});
			loader.load(new URLRequest("resource/map/"+id+"/ground.jpg"));
			var landformLoader:Loader = new Loader();
			landformLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,
			function ():void
			{
				mMapView.landform = landformLoader.content;
				Charactor.astar.analyze(mMapView.landform);
			});
			landformLoader.load(new URLRequest("resource/map/"+id+"/landform.png"));
		}
		
		public function addCharactor(chara:Charactor):void
		{
			mCharactors.push(chara);
			mMapView.addSwapElement(chara.view);
		}
		
		public function attachLayer(layer:Sprite):void
		{
			layer.addChild(mMapView);
		}
		
		public function detachLayer():void
		{
			mMapView.parent && mMapView.removeChild(mMapView);
		}
		
		public function update():void
		{
			mCamera.update();
		}
	}
}