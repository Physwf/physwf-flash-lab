package com.physwf.system
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.components.rpc.msg.MessageManager;
	import com.physwf.components.rpc.msg.MsgBase;
	import com.physwf.system.entity.BagSystem;
	import com.physwf.system.entity.LootSystem;
	import com.physwf.system.entity.FightSystem;
	import com.physwf.system.entity.MapSystem;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.entity.NPCSystem;
	import com.physwf.system.entity.SkillSystem;
	import com.physwf.system.entity.TaskSystem;
	import com.physwf.system.events.MyEvent;
	
	import flash.utils.getTimer;
	
	import mx.utils.RPCObjectUtil;

	public class System
	{
		private static var _myself:MySelf;
		private static var _map:MapSystem;
		private static var _npc:NPCSystem;
		private static var _bag:BagSystem;
		private static var _fight:FightSystem;
		private static var _skill:SkillSystem;
		private static var _loot:LootSystem;
		private static var _task:TaskSystem;
		
		private static var _systemTime:uint;
		private static var _lastTimer:uint;
		
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
			_bag = new BagSystem();
			_fight = new FightSystem();
			_skill = new SkillSystem();
			_loot = new LootSystem();
			_task = new TaskSystem();
			
			_myself.initialize();
			_map.initialize();
			_npc.initialize();
			_bag.initialize();
			_fight.initialize();
			_skill.initialize();
			_loot.initialize();
			_task.initialize();
			
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1003,onSystemTime);
		}
		
		private static function onSystemTime(e:MessageEvent):void
		{
			_lastTimer = getTimer();
			_systemTime = MSG_RES_GET_SYS_TIME_1003(e.message).timestamp;
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
		
		public static function get bag():BagSystem
		{
			return _bag;
		}
		
		public static function get fight():FightSystem
		{
			return _fight;
		}
		
		public static function get skill():SkillSystem
		{
			return _skill;
		}
		
		public static function get loot():LootSystem
		{
			return _loot;
		}
		
		public static function get task():TaskSystem
		{
			return _task;
		}
		
		public static function get systemTime():uint 
		{
			var curTimer:uint = getTimer();
			_systemTime += curTimer - _lastTimer;
			_lastTimer = curTimer;
			return _systemTime;
		}
	}
}