package com.physwf.system.entity 
{
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.vo.MapInfo;
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.EventDispatcher;

	public class MapSystem extends EventDispatcher
	{
		public static const TYPE_PALYER:uint = 1;
		public static const TYPE_PET:uint = 2;
		public static const TYPE_MONSTER:uint = 3;
		
		public var mapInfo:MapInfo;
		public var mapUserList:Vector.<UserInfo>;
		
		public function MapSystem() 
		{
			
		}
		
		public function initialize():void
		{
		}
		
		public function onMapSwitchStart():void
		{
		}
		
		public function onMapSwitchEnd():void
		{
		}
		
		public function getMapUserList():void
		{
		}
		
		private function onMessage(e:MessageEvent):void
		{
		}
	} 
}