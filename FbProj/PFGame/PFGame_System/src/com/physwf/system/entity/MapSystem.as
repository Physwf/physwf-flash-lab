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
			
		}
		
		public function onMapSwitchStart():void
		{
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+0x1033,onMessage);//user move
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+0x1005,onMessage);//user leave map notify
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+0x1006,onMessage);//user enter map notify
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+0x1007,onMessage);//map user list
		}
		
		public function onMapSwitchEnd():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+0x1033,onMessage);//user move
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+0x1005,onMessage);//user leave map notify
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+0x1006,onMessage);//user enter map notify
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+0x1007,onMessage);//map user list
		}
		
		public function getMapUserList():void
		{
			var msg:MSG_REQ_WORLD_GET_MAP_USER_0x1007 = new MSG_REQ_WORLD_GET_MAP_USER_0x1007();
			RPCConnectioin.online.call(msg);
		}
		
		private function onMessage(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+0x1033://user move
					if(!mapUserList) return;
					var msg1033:MSG_RES_WORLD_USER_MOVE_NOTIFY_0x1033 = e.message as MSG_RES_WORLD_USER_MOVE_NOTIFY_0x1033;
					var uInfo:UserInfo = getMapUserInfoById(msg1033.uid);
					uInfo.target_x = msg1033.pos.x;
					uInfo.target_y = msg1033.pos.y;
					dispatchEvent(new MapEvent(MapEvent.MAP_USER_MOVE,uInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+0x1005://user leave map notify
					if(!mapUserList) return;
					var msg1005:MSG_RES_WORLD_LEAVE_MAP_NOTIFY_0x1005 = e.message as MSG_RES_WORLD_LEAVE_MAP_NOTIFY_0x1005;
					uInfo = getMapUserInfoById(msg1005.uid);
					dispatchEvent(new MapEvent(MapEvent.MAP_USER_LEAVE_MAP,uInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+0x1006://user enter map notify
					if(!mapUserList) return;
					var msg1006:MSG_RES_WORLD_ENTER_MAP_NOTIFY_0x1006 = e.message as MSG_RES_WORLD_ENTER_MAP_NOTIFY_0x1006;
					uInfo = new UserInfo();
					uInfo.uid = msg1006.user_info.uid;
					uInfo.nick = msg1006.user_info.nick;
					uInfo.sex = msg1006.user_info.sex;
					uInfo.map_x = msg1006.user_info.pos.x;
					uInfo.map_y = msg1006.user_info.pos.y;
					mapUserList.push(uInfo);
					dispatchEvent(new MapEvent(MapEvent.MAP_USER_ENTER_MAP,uInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+0x1007://map user list
					var msg1007:MSG_RES_WORLD_GET_MAP_USER_0x1007 = e.message as MSG_RES_WORLD_GET_MAP_USER_0x1007;
					var users:Vector.<world_user_map_show_info_t> = msg1007.users_info;
					var len:uint = users.length;
					mapUserList = new Vector.<UserInfo>();
					for(var i:uint=0;i<len;++i)
					{
						uInfo = new UserInfo();
						uInfo.uid = users[i].uid;
						uInfo.nick = users[i].nick;
						uInfo.sex = users[i].sex;
						uInfo.map_x = users[i].pos.x;
						uInfo.map_y = users[i].pos.y;
						mapUserList.push(uInfo);
					}
					dispatchEvent(new MapEvent(MapEvent.MAP_USER_LIST_SUCCESS));
					break;
			}
		}
		
		public function getMapUserInfoById(uid:uint,remove:Boolean=false):UserInfo
		{
			var ret:UserInfo = null;
			for(var i:uint=0;i<mapUserList.length;++i)
			{
				if(mapUserList[i].uid == uid)
				{
					ret = mapUserList[i];
					if(remove) 
					{
						mapUserList.splice(i,1);
					}
				}
			}
			return ret;
		}
	} 
}