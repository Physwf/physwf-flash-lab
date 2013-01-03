package com.physwf.application.login.services
{
	import com.adobe.crypto.MD5;
	import com.physwf.application.login.cache.LoginContext;
	import com.physwf.application.login.msg.MSG_REQ_CREATE_ROLE_107;
	import com.physwf.application.login.msg.MSG_REQ_GET_RECOMMEND_SVR_LIST_105;
	import com.physwf.application.login.msg.MSG_REQ_GET_ROLE_INFO_106;
	import com.physwf.application.login.msg.MSG_REQ_LOGIN_103;
	import com.physwf.application.login.msg.MessageManager;
	import com.physwf.application.login.rpc.RPCClient;
	import com.physwf.system.entity.MySelf;

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
			MySelf.loginInfo.userID = uid;
			MySelf.loginInfo.password = password;
			MySelf.loginInfo.which_game = LoginContext.which_game;
			var msg:MSG_REQ_LOGIN_103 = new MSG_REQ_LOGIN_103();
			msg.uid = uint(uid);
			msg.password = MD5.hash(MD5.hash(password));//要哈希
			msg.channel = LoginContext.channel;
			msg.which_game = LoginContext.which_game ;
			msg.user_ip = LoginContext.user_ip;
			msg.img_id = LoginContext.img_id;
			msg.verify_code  = LoginContext.img_id;
//			msg.tag = LoginContext.tag;
			RPCClient.call(msg);
		}
		
		public function getServerList():void
		{
			var msg:MSG_REQ_GET_RECOMMEND_SVR_LIST_105 = new MSG_REQ_GET_RECOMMEND_SVR_LIST_105();
			msg.session = MySelf.loginInfo.session.readUTFBytes(MySelf.loginInfo.session.length);
			msg.tad = LoginContext.tag as String;
			RPCClient.call(msg);
		}
		
		public function getRoles():void
		{
			var msg:MSG_REQ_GET_ROLE_INFO_106 = new MSG_REQ_GET_ROLE_INFO_106();
//			msg.area_id = 
			msg.session = MySelf.loginInfo.session.readUTFBytes(MySelf.loginInfo.session.length);
//			msg.tad
			RPCClient.call(msg);
		}
		
		public function createRole(nick:String,prof:uint):void
		{
			var msg:MSG_REQ_CREATE_ROLE_107 = new MSG_REQ_CREATE_ROLE_107();
//			msg.area_id
			msg.nick = nick;
			msg.prof = prof;
//			msg.channel
			msg.session = MySelf.loginInfo.session.readUTFBytes(MySelf.loginInfo.session.length);
			//			msg.tad
			RPCClient.call(msg);
		}
	}
}