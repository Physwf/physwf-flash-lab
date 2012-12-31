package com.physwf.system.services
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.system.entity.MySelf;

	public class MyService
	{
		public function MyService()
		{
		}
		
		public function login():void
		{
			var msg_login:MSG_REQ_LOGIN_1001 = new MSG_REQ_LOGIN_1001();
			msg_login.from_game = MySelf.loginInfo.which_game;
//			msg_login.to_game =;
			msg_login.sess = MySelf.loginInfo.session.readUTFBytes(MySelf.loginInfo.session.length);
			RPCConnectioin.online.call(msg_login);
		}
		
	}
}