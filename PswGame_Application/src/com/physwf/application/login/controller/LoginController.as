package com.physwf.application.login.controller
{
	import com.physwf.application.login.cache.LoginContext;
	import com.physwf.application.login.rpc.MessageEvent;
	import com.physwf.application.login.rpc.RPCClient;

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
		}
		
		private function onMessage(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+103:
				{
					onLoginSuccess();
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