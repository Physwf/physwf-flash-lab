package com.physwf.application.login.controller
{
	import com.physwf.application.login.cache.LoginContext;
	import com.physwf.application.login.cache.OnlineInfo;
	import com.physwf.application.login.msg.MsgBase;
	import com.physwf.application.login.rpc.MessageEvent;
	import com.physwf.application.login.rpc.RPCClient;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.vo.RoleInfo;
	import com.physwf.system.vo.ServerInfo;

	public class LoginController
	{
		public static var instance:LoginController = new LoginController();
		
		public var onLoginSuccess:Function;
		public var onLoginError:Function;
		public var onGetServerList:Function;
		public var onGetRoles:Function;
		public var onRoleCreated:Function;
		
		public function LoginController()
		{
		}
		
		public function initialize():void
		{
			RPCClient.addEventListener(MessageEvent.MSG_SUCCESS_ + 0x0001,onMessage);//verify user
			RPCClient.addEventListener(MessageEvent.MSG_SUCCESS_ + 0x9001,onMessage);//check role exsit yes
			RPCClient.addEventListener(MessageEvent.MSG_ERROR_ + 0x9001,onMessage);//check role exsit no
			
			RPCClient.addEventListener(MessageEvent.MSG_SUCCESS_ + 0x9000,onMessage);// create role
			RPCClient.addEventListener(MessageEvent.MSG_SUCCESS_ + 0x6004,onMessage);//get world list
			
		}
		
		private function onMessage(e:MessageEvent):void
		{
			var msg:MsgBase = e.message;
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_ + 0x0001:
					MySelf.userInfo.uid = msg.userID;
					MsgBase.UID = msg.userID;
					onLoginSuccess();
					break;
				case MessageEvent.MSG_SUCCESS_ + 0x9001:
					break;
				case MessageEvent.MSG_ERROR_ + 0x9001:
					break;
				case MessageEvent.MSG_SUCCESS_ + 0x9000:
					break;
				case MessageEvent.MSG_SUCCESS_ + 0x6004:
					break;
			}
		}
	}
}