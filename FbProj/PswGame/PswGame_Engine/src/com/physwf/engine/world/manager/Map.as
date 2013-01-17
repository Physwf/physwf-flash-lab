package com.physwf.engine.world.manager
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.MapView;
	import com.physwf.components.map.camera.Camera;
	import com.physwf.engine.Engine;
	import com.physwf.engine.world.controllers.MapController;
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
	import flash.system.ApplicationDomain;

	public class Map extends EventDispatcher implements IUpdatable
	{
		/**
		 * 地图的应用程序域用来存放属于该地图的应用，如客户端npc，npc脚本，地图脚本等 
		 */		
		private var mAppDomain:ApplicationDomain;
		
		private var mMapView:MapView;
		private var mCamera:Camera;
		
		private var mController:MapController;
		
		private var mCharactors:Vector.<Charactor>;
		
		public function Map()
		{
			mMapView = new MapView();
			mCamera = new Camera(new Rectangle(0,0,1000,600));
			
			Charactor.self = new Charactor();
			MySelf.userInfo.map_x = 626;
			MySelf.userInfo.map_y = 566;
			Charactor.self.initialize(MySelf.userInfo);
			
			mCharactors = new <Charactor>[];
			addCharactor(Charactor.self);
			
			mCamera.target = Charactor.self.view;
			mCamera.initialize(mMapView);
			
			Engine.map = this;
		}
		
		public function initialize():void
		{
			System.map.addEventListener(MapEvent.MAP_USER_LIST_SUCCESS,onMapEvent);
			System.map.addEventListener(MapEvent.MAP_USER_ENTER_MAP,onMapEvent);
			System.map.addEventListener(MapEvent.MAP_USER_LEAVE_MAP,onMapEvent);
			System.map.addEventListener(MapEvent.MAP_USER_MOVE,onMapEvent);
			System.myself.addEventListener(MyEvent.ENTER_MAP_SUCCESS,onMyEvent);
			System.myself.addEventListener(MyEvent.SELF_MOVE_ALLOWED,onMyEvent);
			
			mController = new MapController();
			mController.initialize(mMapView);
		}
		
		private function onMapEvent(e:MapEvent):void
		{
			var chara:Charactor;
			switch(e.type)
			{
				case MapEvent.MAP_USER_ENTER_MAP:
					chara = new Charactor();
					chara.initialize(e.userInfo);
					addCharactor(chara);
					break;
				case MapEvent.MAP_USER_LEAVE_MAP:
					delCharactor(e.userInfo);
					break;
				case MapEvent.MAP_USER_LIST_DETAIL_SUCCESS:
					break;
				case MapEvent.MAP_USER_LIST_SUCCESS:
					var mapUserList:Vector.<UserInfo> = System.map.mapUserList;
					for(var i:int=0;i<mapUserList.length;i++)
					{
						chara = new Charactor();
						chara.initialize(mapUserList[i]);
						addCharactor(chara);
					}
					break;
				case MapEvent.MAP_USER_MOVE:
					// to do 根据userInfo找到相应的character，然后设置该character到指定点
					for(var j:int=0;j<mCharactors.length;++j)
					{
						if(mCharactors[j].userId == e.userInfo.uid)
						{
							mCharactors[j].goto(e.userInfo.target_x,e.userInfo.target_y);
						}
					}
					break;
			}
		}
		
		private function onMyEvent(e:MyEvent):void
		{
			switch(e.type)
			{
				case MyEvent.ENTER_MAP_SUCCESS:
					break;
				case MyEvent.SELF_MOVE_ALLOWED:
					Charactor.self.goto(mController.targetX,mController.targetY);
					break;
			}
		}
		
		public function load():void
		{
			var id:uint = MySelf.userInfo.map_id;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(
				Event.COMPLETE,
				function (e:Event):void 
				{
					mMapView.clearBottom();
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
		/**
		 * 加载客户端的npc配置，根据npc配置信息，它将创建npc显示
		 * 
		 */		
		public function loadClientNPC():void
		{
			
		}
		/**
		 *加载npc脚本，npc脚本主要用来实现NPC同用户的状态或者用户的操作进行交互逻辑
		 * 
		 */		
		public function loadNPCScript():void
		{
			
		}
		/**
		 * 加载地图脚本，地图脚本用来根据玩家当前状态（如任务状态）来改变地图显示（如隐藏其他玩家，控制环境等）
		 * 这些都是客户端状态，与服务端无关 
		 */		
		public function loadMapScript():void
		{
			
		}
		
		public function addCharactor(chara:Charactor):void
		{
			mCharactors.push(chara);
			mMapView.addSwapElement(chara.view);
		}
		
		public function delCharactor(info:UserInfo):void
		{
			for(var i:int=0;i<mCharactors.length;++i)
			{
				if(mCharactors[i].userId == info.uid)
				{
					mMapView.removeSwapElement(mCharactors[i].view);
					mCharactors.splice(i,1);
				}
			}
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
			for(var i:int=0;i<mCharactors.length;++i)
			{
				mCharactors[i].update();
			}
			mCamera.update();
		}
		
		public function set domain(value:ApplicationDomain):void { mAppDomain = value; }
		public function get view():MapView { return mMapView; }
		public function get camera():Camera { return mCamera; }
	}
}