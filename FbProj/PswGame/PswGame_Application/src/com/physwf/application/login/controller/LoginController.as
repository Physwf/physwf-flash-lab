package com.physwf.application.login.controller
{
	import com.physwf.application.login.cache.LoginContext;
	import com.physwf.application.login.msg.MSG_RES_LOGIN_103;
	import com.physwf.application.login.msg.MsgBase;
	import com.physwf.application.login.rpc.MessageEvent;
	import com.physwf.application.login.rpc.RPCClient;
	import com.physwf.system.entity.MySelf;

	public class LoginController
	{
		public static var instance:LoginController = new LoginController();
		
		public var onLoginSuccess:Function;

		public function LoginController()
		{
		}
		
		public function initialize():void
		{
			RPCClient.addEventListener(MessageEvent.MSG_SUCCESS_+103,onMessage);
			RPCClient.addEventListener(MessageEvent.MSG_ERROR_+103,onMessage);
		}
		
		private function onMessage(e:MessageEvent):void
		{
			var msg:MsgBase = e.message;
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+103:
				{
					MySelf.loginInfo.session = MSG_RES_LOGIN_103(msg).session;
					onLoginSuccess();
					break;
				}
				case MessageEvent.MSG_ERROR_+103:
				{
					LoginContext.img_id = MSG_RES_LOGIN_103(msg).img_id;
					LoginContext.img_data = MSG_RES_LOGIN_103(msg).img_data;
//					onLoginSuccess();
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
	}
}