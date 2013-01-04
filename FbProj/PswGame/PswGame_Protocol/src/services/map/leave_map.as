package services.map
{
	import com.physwf.components.rpc.RPCConnectioin;

	public function leave_map()
	{
		RPCConnectioin.online.call(new MSG_REQ_LEAVE_MAP_1031());
	}
}