package com.physwf.engine.world.objects
{
	import com.physwf.components.command.LinerCmdSequence;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.MapView;
	import com.physwf.components.map.camera.Camera;
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.command.CmdGoAlong;
	import com.physwf.engine.common.command.CmdGoTo;
	import com.physwf.engine.common.command.CmdStand;
	import com.physwf.engine.script.IMapScript;
	import com.physwf.engine.world.controllers.MapController;
	import com.physwf.engine.world.controllers.SelfController;
	import com.physwf.engine.world.events.WorldEvent;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.events.MapEvent;
	import com.physwf.system.events.MyEvent;
	import com.physwf.system.events.NPCEvent;
	import com.physwf.system.vo.MonsterInfo;
	import com.physwf.system.vo.UserInfo;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	

	public class Map extends EventDispatcher implements IUpdatable
	{
		/**
		 * 地图的应用程序域用来存放属于该地图的应用，如客户端npc，npc脚本，地图脚本等 
		 */		
		private var mAppDomain:ApplicationDomain;
		
		private var mMapView:MapView;
		private var mCamera:Camera;
		
		private var mController:MapController;
		
		private var mCharactors:Vector.<Player>;
		private var mMonsters:Vector.<Monster>;
		private var mNpcs:Vector.<NPC>;
		private var mTeleprots:Vector.<Teleport>;
		
		private var mScript:IMapScript;
		
		public function Map()
		{
			Engine.map = this;
			
			mMapView = new MapView();
			mCamera = new Camera(new Rectangle(0,0,1000,600));
			
			Character.managers = new Dictionary();//后面要放到地图初始化时清空，但要保留自己的数据
			
			Player.self = new Player();
//			MySelf.userInfo.map_x = 626;
//			MySelf.userInfo.map_y = 566;
			Player.self.initialize(MySelf.userInfo);
			
			// 只有self 才需要controller
			Player.controller = new SelfController();
			Player.controller.initialize(Player.self,MySelf.userInfo);
			
			mCharactors = new <Player>[];
			addPlayer(Player.self);
			
			mMonsters = new <Monster>[];
			mNpcs = new <NPC>[];
			mTeleprots = new <Teleport>[];
			
			mCamera.target = Player.self.view;
			mCamera.initialize(mMapView);
		}
		
		public function initialize():void
		{
			System.map.addEventListener(MapEvent.MAP_USER_LIST_SUCCESS,onMapEvent);
			System.map.addEventListener(MapEvent.MAP_USER_ENTER_MAP,onMapEvent);
			System.map.addEventListener(MapEvent.MAP_USER_LEAVE_MAP,onMapEvent);
			System.map.addEventListener(MapEvent.MAP_USER_MOVE,onMapEvent);
			
			System.npc.addEventListener(NPCEvent.NPC_LIST,onNPCEvent);
			System.npc.addEventListener(NPCEvent.NPC_REFRESH,onNPCEvent);
			System.npc.addEventListener(NPCEvent.NPC_MOVE,onNPCEvent);
			
			System.myself.addEventListener(MyEvent.ENTER_MAP_SUCCESS,onMyEvent);
			System.myself.addEventListener(MyEvent.SELF_MOVE_ALLOWED,onMyEvent);
			
			mController = new MapController();
			mController.initialize(mMapView);
		}
		
		private function onMapEvent(e:MapEvent):void
		{
			var chara:Player;
			switch(e.type)
			{
				case MapEvent.MAP_USER_ENTER_MAP:
					chara = new Player();
					chara.initialize(e.userInfo);
					addPlayer(chara);
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
						chara = new Player();
						chara.initialize(mapUserList[i]);
						addPlayer(chara);
					}
					dispatchEvent(new WorldEvent(WorldEvent.USERS_READY));
					break;
				case MapEvent.MAP_USER_MOVE:
					// to do 根据userInfo找到相应的Player，然后设置该Player到指定点
					var player:Player = getPlayerByUID(e.userInfo.uid);
					var cmdSeq:LinerCmdSequence = new LinerCmdSequence();
//					var goAlong:CmdGoAlong = new CmdGoAlong(player);
//					goAlong.setPath(e.userInfo.path);
					var goTo:CmdGoTo = new CmdGoTo(player);
					goTo.setDest(e.userInfo.path[0],e.userInfo.path[1]);
					var standCmd:CmdStand = new CmdStand(player);
					cmdSeq.addCommand(goTo);
					cmdSeq.addCommand(standCmd);
					player.execute(cmdSeq);
					break;
				
			}
		}
		
		private function onNPCEvent(e:NPCEvent):void
		{
			switch(e.type)
			{
				case NPCEvent.NPC_LIST:
					var monList:Vector.<MonsterInfo> = System.npc.svrNpcList;
					var mon:Monster;
					for(var i:int=0;i<monList.length;++i)
					{
						mon = new Monster();
						mon.initialize(monList[i]);
						addMonster(mon);
					}
					dispatchEvent(new WorldEvent(WorldEvent.MONS_READY));
					break;
				case NPCEvent.NPC_REFRESH:
					var info:MonsterInfo = e.info;
					refreshMonster(info);
					break;
				case NPCEvent.NPC_MOVE:
					info = e.info;
					mon = getMonsterByMID(info.instanceID);
					var cmdSeq:LinerCmdSequence = new LinerCmdSequence();
					var goAlong:CmdGoAlong = new CmdGoAlong(mon);
					goAlong.setPath(info.path);
					cmdSeq.addCommand(goAlong);
					cmdSeq.addCommand(new CmdStand(mon));
					mon.execute(cmdSeq);
//					mon.goAlong(info.path);
					break;
			}
		}
		
		private function onMyEvent(e:MyEvent):void
		{
			switch(e.type)
			{
				case MyEvent.ENTER_MAP_SUCCESS:
					Player.self.view.x = MySelf.userInfo.map_x;
					Player.self.view.y = MySelf.userInfo.map_y;
					mCamera.moveToTarget();
					break;
				case MyEvent.SELF_MOVE_ALLOWED:
					var cmdSeq:LinerCmdSequence = new LinerCmdSequence();
					var goCmd:CmdGoTo= new CmdGoTo(Player.self);
					goCmd.setDest(mController.targetX,mController.targetY);
					var standCmd:CmdStand = new CmdStand(Player.self);
					cmdSeq.addCommand(goCmd);
					cmdSeq.addCommand(standCmd);
					Player.self.execute(cmdSeq);
//					Player.self.goto(mController.targetX,mController.targetY);
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
					mCamera.moveToTarget();
				});
			loader.load(new URLRequest("resource/map/"+id+"/ground.jpg"));
//			var ground:TileGround = new TileGround();
//			ground.addEventListener(Event.COMPLETE ,function (e:Event):void
//			{
//				mMapView.clearBottom();
//				mMapView.fillBottom(ground);
//			});
//			ground.load(new URLRequest("resource/map/"+id+"/ground.map"));
			
			var landformLoader:Loader = new Loader();
			landformLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,
			function (e:Event):void
			{
				mMapView.landform = landformLoader.content;
				Character.astar.analyze(mMapView.landform);
				dispatchEvent(new WorldEvent(WorldEvent.MAP_READY));
			});
			landformLoader.load(new URLRequest("resource/map/"+id+"/landform.png"));
		}
		/**
		 * 卸载地形等显示层 
		 */		
		public function unload():void
		{
			mMapView.clearBottom();
			mMapView.landform = null;
		}
		/**
		 * 加载地图脚本，该脚本包含 地图配置信息 如npc信息 和 如下逻辑：
		 * 根据玩家当前状态（如任务状态）来
		 * 1.改变地图显示（如隐藏其他玩家，控制环境等）
		 * 2.选择创建npc，设置npc状态
		 * 这些都是客户端状态，与服务端无关 
		 */		
		public function loadMapScript():void
		{
			var id:uint = MySelf.userInfo.map_id;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function (e:Event):void
			{
				mScript = loader.content as IMapScript;
				mScript.initialize();
				loader.unload();
				dispatchEvent(new WorldEvent(WorldEvent.NPCS_READY));
			});
			var contex:LoaderContext = new LoaderContext(false,mAppDomain);
			loader.load(new URLRequest("script/map/Script_Map_"+id+".swf"),contex);
		}
		
		public function unloadMapScript():void
		{
			mScript && mScript.destroy();
			mScript = null;
		}
		
		public function addPlayer(chara:Player):void
		{
			mCharactors.push(chara);
			mMapView.addSwapElement(chara.view);
		}
		
		public function delCharactor(info:UserInfo):void
		{
			for(var i:int=0;i<mCharactors.length;++i)
			{
				if(mCharactors[i].id == info.uid)
				{
					mMapView.removeSwapElement(mCharactors[i].view);
					var player:Player = mCharactors[i];
					mCharactors.splice(i,1);
					player.destroy()
				}
			}
		}
		
		public function delMonster(info:MonsterInfo):void
		{
			for(var i:int=0;i<mMonsters.length;++i)
			{
				if(mMonsters[i].id == info.instanceID)
				{
					mMapView.removeSwapElement(mMonsters[i].view);
					var mons:Monster = mMonsters[i];
					mMonsters.splice(i,1);
					mons.destroy();
				}
			}
		}
		
		public function addMonster(mon:Monster):void
		{
			mMonsters.push(mon);
			mMapView.addSwapElement(mon.view);
		}
		
		public function addNPC(npc:NPC):void
		{
			mNpcs.push(npc);
			mMapView.addSwapElement(npc.view);
		}
		
		public function delNPC(id:uint):void
		{
			for(var i:int=0;i<mNpcs.length;++i)
			{
				if(mNpcs[i].id == id)
				{
					mMapView.removeSwapElement(mNpcs[i].view);
					mNpcs[i].destroy()
					mNpcs.splice(i,1);
				}
			}
		}
		
		public function refreshMonster(info:MonsterInfo):void
		{
			for(var i:int=0;i<mMonsters.length;++i)
			{
				if(mMonsters[i].id == info.instanceID)
				{
					if(info.hp == 0)
					{
						mMapView.removeSwapElement(mMonsters[i].view);
						mMonsters.splice(i,1);
					}
					else
					{
						mMonsters[i].view.x = info.map_x;
						mMonsters[i].view.y = info.map_y;
						//后面还要增加怪物血量的显示更新
					}
				}
			}
		}
		/**
		 * 添加传送点 
		 * @param tp
		 * 
		 */		
		public function addTeleport(tp:Teleport):void
		{
			mTeleprots.push(tp);
			mMapView.addSwapElement(tp.view);
		}
		/**
		 * 清扫场景 
		 */		
		public function sweep():void
		{
			for(var i:uint=0;i<mCharactors.length;++i)
			{
				if(mCharactors[i] == Player.self) continue;
				mMapView.removeSwapElement(mCharactors[i].view);
				mCharactors.splice(i,1);
			}
			for(i=0;i<mMonsters.length;++i)
			{
				mMapView.removeSwapElement(mMonsters[i].view);
				mMonsters.splice(i,1);
			}
			for(i=0;i<mNpcs.length;++i)
			{
				mMapView.removeSwapElement(mNpcs[i].view);
				mNpcs.splice(i,1);
			}
			for(i=0;i<mTeleprots.length;++i)
			{
				mMapView.removeSwapElement(mTeleprots[i].view);
				mTeleprots.splice(i,1);
			}
		}
		
		/**
		 * 获取玩家
		 * @param uid
		 * @return 
		 */		
		public function getPlayerByUID(uid:uint):Player
		{
			for(var j:int=0;j<mCharactors.length;++j)
			{
				if(mCharactors[j].id == uid)
				{
					return mCharactors[j];
				}
			}
			return null;
		}
		/**
		 * 获取怪物
		 * @param mid 实例id
		 * @return 
		 */		
		public function getMonsterByMID(mid:uint):Monster
		{
			for(var j:int=0;j<mMonsters.length;++j)
			{
				if(mMonsters[j].id == mid)
				{
					return mMonsters[j];
				}
			}
			return null;
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
			for(i=0;i<mMonsters.length;++i)
			{
				mMonsters[i].update();
			}
			for(i=0;i<mNpcs.length;++i)
			{
				mNpcs[i].update();
			}
			for(i=0;i<mTeleprots.length;++i)
			{
				mTeleprots[i].update();
			}
			Player.controller.update();
			mMapView.update();
			mCamera.update();
			if(mScript) mScript.update();
		}
		
		public function set domain(value:ApplicationDomain):void { mAppDomain = value; }
		public function get view():MapView { return mMapView; }
		public function get camera():Camera { return mCamera; }
	}
}