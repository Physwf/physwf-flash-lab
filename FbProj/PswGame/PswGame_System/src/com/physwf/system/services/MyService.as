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
			var msg:MSG_REQ_LOGIN_1001 = new MSG_REQ_LOGIN_1001();
			msg.from_game = MySelf.loginInfo.which_game;
			msg.to_game = 0;
			msg.sess = MySelf.loginInfo.session.readUTFBytes(MySelf.loginInfo.session.length);
			msg.tad = MySelf.loginInfo.tad;
			msg.role_tm = MySelf.loginInfo.roleInfo.createTime;
			RPCConnectioin.online.call(msg);
		}
		
		
	}
}