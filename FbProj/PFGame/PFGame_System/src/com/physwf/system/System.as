package com.physwf.system
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.msg.MessageManager;
	import com.physwf.system.entity.MapSystem;
	import com.physwf.system.entity.MySelf;

	public class System
	{
		private static var _myself:MySelf;
		private static var _map:MapSystem;
		
		public function System()
		{
		}
		


		public static function initialize():void
		{
			RPCConnectioin.online = RPCConnectioin.login;
//			RPCConnectioin.online.initialze();
			
//			MessageManager.instance.initialize();
//			MessageManager.instance.registerMessage();
			MessageManager.instance.setMsgUID(uint(MySelf.loginInfo.userID));
			
			_myself = new MySelf();
			_map = new MapSystem();
			
			_myself.initialize();
			_map.initialize();
			
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
	}
}