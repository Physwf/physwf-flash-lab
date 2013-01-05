package com.physwf.system
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.system.entity.MapSystem;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.events.MyEvent;

	public class System
	{
		private static var _myself:MySelf;
		private static var _map:MapSystem;
		
		public function System()
		{
		}
		
		public static function initialize():void
		{
			RPCConnectioin.online = new RPCConnectioin();
			_myself = new MySelf();
			_map = new MapSystem();
			
			_myself.initialize();
			_map.initialize();
			
			_myself.addEventListener(MyEvent.LOGIN_SUCCESS,onLoginSuccess);
		}
		
		private static function onLoginSuccess(e:MyEvent):void
		{
			_myself.enterMap(
				MySelf.userInfo.map_id,
				MySelf.userInfo.map_x,
				MySelf.userInfo.map_y);
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