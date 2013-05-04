package com.physwf.application.login.services
{
	import com.physwf.application.login.cache.LoginContext;
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.msg.MessageManager;
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
			MessageManager.instance.registerMessage();
			RPCConnectioin.login = new RPCConnectioin();
			RPCConnectioin.login.initialze();
		}
		
		public function connectLoginServer(host:String,port:uint,onConnected:Function=null):void
		{
			RPCConnectioin.login.connect({host:host,port:port},onConnected);
		}
		//verify user
		public function login(uid:String,password:String):void
		{
			MySelf.loginInfo.userID = uid;
			MySelf.loginInfo.password = password;
			MySelf.loginInfo.which_game = LoginContext.which_game;
			var msg:MSG_REQ_LOGIN_VERIFY_USER_0x0001 = new MSG_REQ_LOGIN_VERIFY_USER_0x0001();
			msg.user_name = uid;
			msg.pw = password;// MD5.hash(MD5.hash(password));//要哈希
			msg.from_site = "temp";
			msg.game_area = 1;
			RPCConnectioin.login.call(msg);
		}
		//check role exsit 
		public function getRoles():void
		{
			var msg:MSG_REQ_ROLE_EXIST_ROLE_0x9001 = new MSG_REQ_ROLE_EXIST_ROLE_0x9001();
			RPCConnectioin.login.call(msg);
		}
		//get world list
		public function getServerList(page:uint=0):void
		{
			var msg:MSG_REQ_SWITCH_GET_WORLD_LIST_0x6004 = new MSG_REQ_SWITCH_GET_WORLD_LIST_0x6004();
			msg.page = page;
			RPCConnectioin.login.call(msg);
		}
		// create role
		public function createRole(nick:String,sex:uint):void
		{
			var msg:MSG_REQ_ROLE_CREATE_ROLE_0x9000 = new MSG_REQ_ROLE_CREATE_ROLE_0x9000();
			msg.nick = nick;
			msg.sex = sex;
			RPCConnectioin.login.call(msg);
		}
		
		public function close():void
		{
			RPCConnectioin.login.close();
		}
	}
}