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
		public var mapInfo:MapInfo;
		public var mapUserList:Vector.<UserInfo>;
		
		public function MapSystem() 
		{
			
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1032,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1033,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1034,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1035,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1037,onMessage);
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
				case MessageEvent.MSG_SUCCESS_+1032://获取地图上的玩家列表
					mapUserList = new <UserInfo>[];
					var msg1032:MSG_RES_GET_MAP_USER_LIST_1032 = e.message as MSG_RES_GET_MAP_USER_LIST_1032;
					for(var i:int=0;i<msg1032.user_infos.length;++i)
					{
						mapUserInfo = msg1032.user_infos[i];
						userInfo = new UserInfo();
						userInfo.uid = mapUserInfo.userid;
						userInfo.createTime = mapUserInfo.role_tm;
						userInfo.nick = mapUserInfo.nick;
						userInfo.map_id = mapUserInfo.mapid;
						userInfo.map_x = mapUserInfo.map_x;
						userInfo.map_y = mapUserInfo.map_y;
						//to do 装备 宠物
						mapUserList.push(userInfo);
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
					userInfo = getUserInfoById(msg1037.uid,false);
					if(!userInfo) return;
					userInfo.target_x = msg1037.x;
					userInfo.target_y = msg1037.y;
					dispatchEvent(new MapEvent(MapEvent.MAP_USER_MOVE,userInfo));
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