package services.map
{
	import com.physwf.components.rpc.RPCConnectioin;

	public function player_move(x:uint,y:uint,dir:uint)
	{
		var msg:MSG_REQ_MAP_PLAYER_MOVE_1036 = new MSG_REQ_MAP_PLAYER_MOVE_1036();
		msg.x = x;
		msg.y = y;
		msg.dir = dir;
		RPCConnectioin.online.call(msg);
	}
}