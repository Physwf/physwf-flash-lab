package com.physwf.application.login.services
{
	import com.adobe.crypto.MD5;
	import com.physwf.application.login.cache.LoginContext;
	import com.physwf.application.login.msg.MSG_REQ_LOGIN_103;
	import com.physwf.application.login.msg.MessageManager;
	import com.physwf.application.login.rpc.RPCClient;

	public class LoginService
	{
		public static var instance:LoginService = new LoginService();
		
		public function LoginService()
		{
		}
		
		public function initialize():void
		{
			MessageManager.instance.initialize();
			RPCClient.initialze();
		}
		
		public function connectLoginServer(host:String,port:uint,onConnected:Function=null):void
		{
			RPCClient.connect({host:host,port:port},onConnected);
		}
		
		public function login(uid:String,password:String):void
		{
			var msg:MSG_REQ_LOGIN_103 = new MSG_REQ_LOGIN_103();
			msg.uid = uint(uid);
			msg.password = MD5.hash(MD5.hash(password));//要哈希
			msg.channel = LoginContext.channel;
			msg.which_game = LoginContext.which_game ;
//			msg.user_ip = LoginContext.user_ip;
//			msg.img_id = LoginContext.img_id;
//			msg.verify_code  = LoginContext.img_id;
//			msg.tag = LoginContext.tag;
			RPCClient.call(msg);
		}
	}
}