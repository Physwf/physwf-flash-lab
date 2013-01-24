package com.physwf.system.entity 
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.events.NPCEvent;
	import com.physwf.system.vo.MonsterInfo;
	
	import flash.events.EventDispatcher;
	/**
	 * 这个npc系统是服务端的npc系统，与此同时客户端也有自己的npc系统，客户端的npc系统通过客户端配置来提供信息
	 * 这些npc信息在服务端不存在。需要对这两个系统进行概念上的区分。 
	 * @author joe
	 * 
	 */
	public class NPCSystem extends EventDispatcher
	{
		public var svrNpcList:Vector.<MonsterInfo>;
//		private var mCntNpcList:Vector.
		public function NPCSystem() 
		{
			
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1038,onNpcMessage);
		}
		
		public function getMonsterList():void
		{
			var msg:MSG_REQ_GET_MAP_MONSTERS_1038 = new MSG_REQ_GET_MAP_MONSTERS_1038();
			RPCConnectioin.online.call(msg);
		}

		private function onNpcMessage(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1038:
					var monsters:Vector.<map_monster_t> = MSG_RES_GET_MAP_MONSTERS_1038(e.message).monsters;
					svrNpcList = new Vector.<MonsterInfo>();
					for(var i:int=0;i<monsters.length;++i)
					{
						var mons:MonsterInfo = new MonsterInfo();
						mons.instanceID = monsters[i].instance_id;
						mons.map_x = monsters[i].map_x;
						mons.map_y = monsters[i].map_y;
						mons.hp = monsters[i].hp;
						mons.mp = monsters[i].mp;
						svrNpcList.push(mons);
					}
					dispatchEvent(new NPCEvent(NPCEvent.NPC_LIST,null));
					break;
			}
		}
	} // end class
} // end package