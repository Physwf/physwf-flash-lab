package com.physwf.system.entity
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.events.FightEvent;
	import com.physwf.system.vo.FightInfo;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class FightSystem extends EventDispatcher
	{
		public function FightSystem()
		{
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1040,onFightMessage);//
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1041,onFightMessage);//战斗结果
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1042,onFightMessage);//目标被打死
		}
		
		public function attack(srcType:uint,objType:uint,objId:uint,skillId:uint):void
		{
			var msg:MSG_REQ_BATTLE_ATTACK_1040 = new MSG_REQ_BATTLE_ATTACK_1040();
			msg.src_type = srcType;
			msg.obj_type = objType;
			msg.obj_id = objId;
			msg.skill_id = skillId;
			RPCConnectioin.online.call(msg);
		}
		
		private function onFightMessage(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1040:
					break;
				case MessageEvent.MSG_SUCCESS_+1041:
					var results:Vector.<atk_result_t> = MSG_RES_NOTI_ATTACK_RESULT_1041(e.message).results;
					var count:uint = results.length;
					var fInfos:Vector.<FightInfo> = new Vector.<FightInfo>();
					for(var i:int=0;i<count;++i)
					{
						var fInfo:FightInfo = new FightInfo();
						fInfo.srcType = results[i].src_type;
						fInfo.srcId = results[i].src_id;
						fInfo.objType = results[i].obj_type;
						fInfo.objId = results[i].obj_id;
						fInfo.hpHurt = results[i].hp_hurt;
						fInfos.push(fInfo);
					}
					dispatchEvent(new FightEvent(FightEvent.FIGHT_RESULT,fInfos));
					break;
				case MessageEvent.MSG_SUCCESS_+1042:
					var msg1041:MSG_RES_NOTI_OBJ_DEAD_1042 = e.message as MSG_RES_NOTI_OBJ_DEAD_1042;
					fInfos = new Vector.<FightInfo>();
					fInfo = new FightInfo();
					fInfo.srcType = msg1041.obj_type;
					fInfo.srcId = msg1041.obj_id;
					fInfos.push(fInfo);
					dispatchEvent(new FightEvent(FightEvent.FIGHT_DEATH,fInfos));
					break;
			}
		}
			
	}
}