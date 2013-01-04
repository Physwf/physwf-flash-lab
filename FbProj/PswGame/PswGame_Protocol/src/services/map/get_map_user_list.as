package services.map
{
	import com.physwf.components.rpc.RPCConnectioin;

	public function get_map_user_list()
	{
		RPCConnectioin.online.call(new MSG_REQ_GET_MAP_USER_LIST_1032());
	}
}