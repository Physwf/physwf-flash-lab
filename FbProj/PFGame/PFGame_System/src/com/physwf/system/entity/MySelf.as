package com.physwf.system.entity
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.events.MyEvent;
	import com.physwf.system.vo.LoginInfo;
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.EventDispatcher;

	public class MySelf extends EventDispatcher
	{
		/**
		 *登陆信息 
		 */		
		public static var loginInfo:LoginInfo = new LoginInfo();;
		/**
		 * 角色信息 
		 */		
		public static var userInfo:UserInfo = new UserInfo();
		
		public function MySelf()
		{
			
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+0x1002,onMessage);//login or enter world
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+0x1003,onMessage);//enter map
		}
		/**
		 * 登陆/enter map 
		 * 
		 */		
		public function login(wid:uint):void
		{
			var msg:MSG_REQ_WORLD_USER_ENTER_0x1002 = new MSG_REQ_WORLD_USER_ENTER_0x1002();
			msg.world_id = wid;
			RPCConnectioin.online.call(msg);
		}
		/**
		 * 移动 old
		 * @param x
		 * @param y
		 * @param dir
		 * 
		 */		
		public function move(x:uint,y:uint,dir:uint):void
		{
			dispatchEvent(new MyEvent(MyEvent.SELF_MOVE_ALLOWED));
		}
		/**
		 * 玩家移动
		 * @param timeStap
		 * @param path
		 * 
		 */		
		public function walkAlong(timeStap:uint,path:Vector.<uint>):void
		{
		}
		/**
		 * 进入地图 
		 * @param mapid
		 * @param x
		 * @param y
		 * 
		 */		
		public function enterMap(mapid:uint,x:uint,y:uint):void
		{
			var msg:MSG_REQ_WORLD_ENTER_MAP_0x1003 = new MSG_REQ_WORLD_ENTER_MAP_0x1003();
			msg.map_id = mapid;
			msg.pos = new world_user_pos_t();
			msg.pos.x = x;
			msg.pos.y = y;
			RPCConnectioin.online.call(msg);
		}
		/**
		 *离开当前地图 
		 * 
		 */		
		public function leaveMap():void
		{
		}
		
		public function changeEquips():void
		{
		}
		
		public function syncPosition(x:uint,y:uint):void
		{
		}
		
		private function onMessage(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+0x1002:
					var msg1002:MSG_RES_WORLD_USER_ENTER_0x1002 = e.message as MSG_RES_WORLD_USER_ENTER_0x1002;
					MySelf.userInfo = new UserInfo();
					MySelf.userInfo.nick = msg1002.user_info.nick;
					MySelf.userInfo.map_id = msg1002.user_info.map_id;
					MySelf.userInfo.sex = msg1002.user_info.sex;
					dispatchEvent(new MyEvent(MyEvent.LOGIN_SUCCESS));
					break;
				case MessageEvent.MSG_SUCCESS_+0x1003:
					var msg1003:MSG_RES_WORLD_ENTER_MAP_0x1003 = e.message as MSG_RES_WORLD_ENTER_MAP_0x1003;
					dispatchEvent(new MyEvent(MyEvent.ENTER_MAP_SUCCESS));
					break;
			}
		}
	}
}