package com.physwf.system
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.components.rpc.msg.MessageManager;
	import com.physwf.components.rpc.msg.MsgBase;
	import com.physwf.system.entity.MapSystem;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.entity.NPCSystem;
	import com.physwf.system.events.MyEvent;
	
	import mx.utils.RPCObjectUtil;

	public class System
	{
		private static var _myself:MySelf;
		private static var _map:MapSystem;
		private static var _npc:NPCSystem;
		
		private static var _systemTime:uint;
		public static function get systemTime():uint {return _systemTime;}
		
		public function System()
		{
		}
		


		public static function initialize():void
		{
			RPCConnectioin.online = new RPCConnectioin();
			RPCConnectioin.online.initialze();
			MessageManager.instance.initialize();
			MessageManager.instance.registerMessage();
			MessageManager.instance.setMsgUID(uint(MySelf.loginInfo.userID));
			
			_myself = new MySelf();
			_map = new MapSystem();
			_npc = new NPCSystem();
			
			_myself.initialize();
			_map.initialize();
			_npc.initialize();
			
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1016,onSystemTime);
		}
		
		private static function onSystemTime(e:MessageEvent):void
		{
			_systemTime = MSG_RES_NOTIFY_SYS_TIME_1016(e.message).time;
		}
		
		public static function estabConnection(ipInfo:Object,onConnect:Function):void
		{
			RPCConnectioin.online.connect(ipInfo,onConnect);
		}
		
		public static function get myself():MySelf
		{
			return _myself;
		}
		
		public static function get map():MapSystem
		{
			return _map;
		}

		public static function get npc():NPCSystem
		{
			return _npc;
		}
	}
}