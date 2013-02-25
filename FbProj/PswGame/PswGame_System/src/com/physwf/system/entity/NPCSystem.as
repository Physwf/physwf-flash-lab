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
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1039,onNpcMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1043,onNpcMessage);//怪物移动
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
				case MessageEvent.MSG_SUCCESS_+1039:
					if(!svrNpcList) return;
					var msg1039:MSG_RES_NOTI_MAP_MONSTERS_1039 = e.message as MSG_RES_NOTI_MAP_MONSTERS_1039;
					var info:map_monster_t = msg1039.monsters;
					var remove:Boolean = (info.hp == 0);
					var mInfo:MonsterInfo = getMonsInfoById(info.instance_id,remove);
					if(!remove)
					{
						mInfo.hp = info.hp;
						mInfo.mp = info.mp;
						mInfo.map_x = info.map_x;
						mInfo.map_y = info.map_y;
					}
					dispatchEvent(new NPCEvent(NPCEvent.NPC_REFRESH,mInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1043:
					if(!svrNpcList) return;
					var msg1043:MSG_RES_NOTI_MONSTER_MOVE_1043 = e.message as MSG_RES_NOTI_MONSTER_MOVE_1043;
					mInfo = getMonsInfoById(msg1043.monster_instance_id,false);
					trace(msg1043.monster_instance_id,"msg1043.monster_instance_id");
					var list:Vector.<map_pos_t> = msg1043.move_list;
					var path:Vector.<uint> = new Vector.<uint>();
					for(i=0;i<list.length;++i)
					{
						path.push(list[i].map_x/10);
						path.push(list[i].map_y/10);
					}
					mInfo.path = path;
					dispatchEvent(new NPCEvent(NPCEvent.NPC_MOVE,mInfo));
					break;
			}
		}
		
		private function getMonsInfoById(instanId:uint,remove:Boolean):MonsterInfo
		{
			var mInfo:MonsterInfo
			for(var i:int=0;i<svrNpcList.length;++i)
			{
				if(svrNpcList[i].instanceID == instanId)
				{
					mInfo = svrNpcList[i];
					if(remove)
						svrNpcList.splice(i,1);
					break;
				}
			}
			return mInfo;
		}
	} // end class
} // end package