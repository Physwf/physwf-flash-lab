package services.system
{
	import com.physwf.components.rpc.RPCConnectioin;

	public function login(which_game:uint,session:String,tad:*,role_time:uint):void
	{
		var msg:MSG_REQ_LOGIN_1001 = new MSG_REQ_LOGIN_1001();
		msg.from_game = which_game;
		msg.to_game = 0;
		msg.sess = session;
		msg.tad = tad;
		msg.role_tm = role_time;
		RPCConnectioin.online.call(msg);
	}
}