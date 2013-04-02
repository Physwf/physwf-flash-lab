package com.physwf.system.entity 
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.events.MapEvent;
	import com.physwf.system.vo.MapInfo;
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.EventDispatcher;

	public class MapSystem extends EventDispatcher
	{
		public static const TYPE_PALYER:uint = 1;
		public static const TYPE_PET:uint = 2;
		public static const TYPE_MONSTER:uint = 3;
		
		public var mapInfo:MapInfo;
		public var mapUserList:Vector.<UserInfo>;
		
		public function MapSystem() 
		{
			
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1028,onMessage);
		}
		
		public function onMapSwitchStart():void
		{
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1032,onMessage);//get map user list
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1033,onMessage);
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1034,onMessage);// notify player enter map
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1035,onMessage);// notify player leave map
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1036,onMessage);// notify player move
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1037,onMessage);// (old) notify player move
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1010,onMessage);// 通知升级
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1011,onMessage);// 通知属性变化
		}
		
		public function onMapSwitchEnd():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1032,onMessage);//get map user list
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1033,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1034,onMessage);// notify player enter map
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1035,onMessage);// notify player leave map
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1036,onMessage);// notify player move
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1037,onMessage);// (old) notify player move
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1010,onMessage);// 通知升级
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1011,onMessage);// 通知属性变化
		}
		
		public function getMapUserList():void
		{
			RPCConnectioin.online.call(new MSG_REQ_GET_MAP_USER_LIST_1032());
		}
		
		private function onMessage(e:MessageEvent):void
		{
			var mapUserInfo:map_user_info;
			var userInfo:UserInfo;
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1028:
					var msg1028:MSG_RES_WALK_1028 = e.message as MSG_RES_WALK_1028;
					for(var j:uint=0;j<msg1028.postions.length;++j)
					{
					}
					break;
				case MessageEvent.MSG_SUCCESS_+1032://获取地图上的玩家列表
					mapUserList = new <UserInfo>[];
					var msg1032:MSG_RES_GET_MAP_USER_LIST_1032 = e.message as MSG_RES_GET_MAP_USER_LIST_1032;
					for(var i:int=0;i<msg1032.user_infos.length;++i)
					{
						mapUserInfo = msg1032.user_infos[i];
						userInfo = new UserInfo();
						userInfo.uid = mapUserInfo.userid;
						userInfo.prof = mapUserInfo.prof;
						userInfo.level = mapUserInfo.level;
						userInfo.hp = mapUserInfo.hp;
						userInfo.hp_max = mapUserInfo.hp_max;
						userInfo.mp = mapUserInfo.mp;
						userInfo.mp_max = mapUserInfo.mp_max;
						userInfo.createTime = mapUserInfo.role_tm;
						userInfo.nick = mapUserInfo.nick;
						userInfo.map_id = mapUserInfo.mapid;
						userInfo.map_x = mapUserInfo.map_x;
						userInfo.map_y = mapUserInfo.map_y;
						//to do 装备 宠物
						mapUserList.push(userInfo);
//						if(mapUserInfo.userid != MySelf.userInfo.uid)
//						{
//
//						}
					}
					dispatchEvent(new MapEvent(MapEvent.MAP_USER_LIST_SUCCESS));
					break;
				case MessageEvent.MSG_SUCCESS_+1033://获取地图上某个玩家的详细信息
					break;
				case MessageEvent.MSG_SUCCESS_+1034://玩家进入地图，
					if(!mapUserList) return;
					var msg1034:MSG_RES_NOTI_ENTER_MAP_1034 = e.message as MSG_RES_NOTI_ENTER_MAP_1034;
					mapUserInfo = msg1034.user;
					userInfo = new UserInfo();
					userInfo.uid = mapUserInfo.userid;
					userInfo.createTime = mapUserInfo.role_tm;
					userInfo.nick = mapUserInfo.nick;
					userInfo.prof = mapUserInfo.prof;
					userInfo.sex = mapUserInfo.role_sex;
					userInfo.level = mapUserInfo.level;
					userInfo.hp = mapUserInfo.hp;
					userInfo.hp_max = mapUserInfo.hp_max;
					userInfo.mp = mapUserInfo.mp;
					userInfo.mp_max = mapUserInfo.mp_max;
					userInfo.map_id = mapUserInfo.mapid;
					userInfo.map_x = mapUserInfo.map_x;
					userInfo.map_y = mapUserInfo.map_y;
					mapUserList.push(userInfo);
					dispatchEvent(new MapEvent(MapEvent.MAP_USER_ENTER_MAP,userInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1035://玩家离开地图
					if(!mapUserList) return;
					var msg1035:MSG_RES_NOTI_LEAVE_MAP_1035 = e.message as MSG_RES_NOTI_LEAVE_MAP_1035;
					var uid:uint = msg1035.user_id;
					userInfo = getUserInfoById(uid,true);
					dispatchEvent(new MapEvent(MapEvent.MAP_USER_LEAVE_MAP,userInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1037://玩家移动
					if(!mapUserList) return;
					var msg1037:MSG_RES_NOTI_USER_MOVE_1037 = e.message as MSG_RES_NOTI_USER_MOVE_1037;
					userInfo = getUserInfoById(msg1037.user_id,false);
					if(!userInfo) return;
					var positions:Vector.<map_pos_t> = msg1037.postions;
					var path:Vector.<uint> = new Vector.<uint>();
					for(i=0;i<positions.length;++i)
					{
						path.push(positions[i].map_x,positions[i].map_y);
					}
					userInfo.path = path;
					dispatchEvent(new MapEvent(MapEvent.MAP_USER_MOVE,userInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1010:
					var msg1010:MSG_RES_USER_LEVEL_UP_1010 = e.message as MSG_RES_USER_LEVEL_UP_1010;
					var uInfo:UserInfo = getUserInfoById(msg1010.user_id,false);
					uInfo.level = msg1010.level;
					dispatchEvent(new MapEvent(MapEvent.MAP_USER_LEVEL_UP,uInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1011:// 通知属性变化
					var msg1011:MSG_RES_NOTI_ATTR_CHANGE_1011 = e.message as MSG_RES_NOTI_ATTR_CHANGE_1011;
					var srcId:uint = msg1011.src_id;
					var srcType:uint = msg1011.src_type;
					if(msg1011.src_type == TYPE_PALYER)
					{
						uInfo = getUserInfoById(srcType,false);
//						uInfo.level = msg1011
						dispatchEvent(new MapEvent(MapEvent.MAP_USER_ATTRI_CHANGE,uInfo));
					}
					// to do 宠物的属性变化和怪物的属性变化 分别要发送宠物事件和怪物事件
					break;
			}
		}
		/**
		 * 从玩家列表中获取到指定uid的玩家信息 
		 * @param uid
		 * @param remove 是否在列表中删除该信息
		 * @return 
		 * 
		 */
		public function getUserInfoById(uid:uint,remove:Boolean):UserInfo
		{
			var userInfo:UserInfo;
			for(var i:int =0;i<mapUserList.length;++i)
			{
				if(mapUserList[i].uid == uid)
				{
					userInfo = mapUserList[i];
					if(remove)
						mapUserList.splice(i,1);
					break;
				}
			}
			return userInfo;
		}
	} 
}