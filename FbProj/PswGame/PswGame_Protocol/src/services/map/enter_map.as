package services.map
{
	import com.physwf.components.rpc.RPCConnectioin;

	public function enter_map(mapid:uint,x:uint,y:uint)
	{
		var msg:MSG_REQ_ENTER_MAP_1030 = new MSG_REQ_ENTER_MAP_1030();
		msg.map_id = mapid;
		msg.map_x = x;
		msg.map_y = y;
		RPCConnectioin.online.call(msg);
	}
}