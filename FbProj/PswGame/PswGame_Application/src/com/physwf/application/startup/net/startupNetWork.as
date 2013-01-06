package com.physwf.application.startup.net
{
	import com.physwf.components.rpc.RPCConnectioin;
	import msg.MessageManager;

	public function startupNetWork():void
	{
		RPCConnectioin.online = new RPCConnectioin();
		MessageManager.instance.registerMessage(1001,MSG_res);
	}
	
}