package com.physwf.system.entity 
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.vo.MapInfo;
	
	import flash.events.EventDispatcher;

	public class MapSystem extends EventDispatcher
	{
		public var mapInfo:MapInfo;
		
		public function MapSystem() 
		{
			
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1032,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1033,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1034,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1035,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1037,onMessage);
		}
		
		public function getMapUserList():void
		{
			RPCConnectioin.online.call(new MSG_REQ_GET_MAP_USER_LIST_1032());
		}
		
		private function onMessage(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1032:
					break;
				case MessageEvent.MSG_SUCCESS_+1033:
					break;
				case MessageEvent.MSG_SUCCESS_+1034:
					break;
				case MessageEvent.MSG_SUCCESS_+1035:
					break;
				case MessageEvent.MSG_SUCCESS_+1037:
					break;
			}
		}

	} 
}