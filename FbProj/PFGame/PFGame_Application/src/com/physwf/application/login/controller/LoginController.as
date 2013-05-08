package com.physwf.application.login.controller
{
	import com.physwf.application.login.cache.OnlineInfo;
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.components.rpc.msg.MsgBase;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.vo.ServerInfo;

	public class LoginController
	{
		public static var instance:LoginController = new LoginController();
		
		public var onLoginSuccess:Function;
		public var onLoginError:Function;
		public var onGetServerList:Function;
		public var onGetRoles:Function;
		public var onNoRoles:Function;
		public var onRoleCreated:Function;
		
		public function LoginController()
		{
		}
		
		public function initialize():void
		{
			RPCConnectioin.login.addEventListener(MessageEvent.MSG_SUCCESS_ + 0x0001,onMessage);//verify user
			RPCConnectioin.login.addEventListener(MessageEvent.MSG_SUCCESS_ + 0x9001,onMessage);//check role exsit yes
			RPCConnectioin.login.addEventListener(MessageEvent.MSG_ERROR_ + 0x9001,onMessage);//check role exsit no
			
			RPCConnectioin.login.addEventListener(MessageEvent.MSG_SUCCESS_ + 0x9000,onMessage);// create role
			RPCConnectioin.login.addEventListener(MessageEvent.MSG_SUCCESS_ + 0x6004,onMessage);//get world list
			
		}
		
		private function onMessage(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_ + 0x0001://verify user
					var msg0001:MSG_RES_LOGIN_VERIFY_USER_0x0001 = e.message as MSG_RES_LOGIN_VERIFY_USER_0x0001;
					MySelf.userInfo.uid = msg0001.userID;
					MySelf.userInfo.createTime = msg0001.reg_time;
					MsgBase.UID = msg0001.userID;
					onLoginSuccess();
					break;
				case MessageEvent.MSG_SUCCESS_ + 0x9001://check role exsit yes
					onGetRoles();
					break;
				case MessageEvent.MSG_ERROR_ + 0x9001://check role exsit no
					onNoRoles();
					break;
				case MessageEvent.MSG_SUCCESS_ + 0x9000:// create role
					onGetRoles();
					break;
				case MessageEvent.MSG_SUCCESS_ + 0x6004://get world list
					var msg6004:MSG_RES_SWITCH_GET_WORLD_LIST_0x6004 = e.message as MSG_RES_SWITCH_GET_WORLD_LIST_0x6004;
					var world_cnt:uint = msg6004.world_cnt;
					OnlineInfo.onlines = new Vector.<ServerInfo>();
					for(var i:uint=0;i<world_cnt;++i)
					{
						var sInfo:ServerInfo = new ServerInfo();
						sInfo.id = msg6004.worlds[i].world_id;
						sInfo.user_num = msg6004.worlds[i].user_cnt;
						OnlineInfo.onlines.push(sInfo);
					}
					onGetServerList();
					break;
			}
		}
	}
}