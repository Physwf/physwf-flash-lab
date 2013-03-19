package com.physwf.system.entity
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.events.DeathEvent;
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
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1045,onFightMessage);
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
					var results:atk_result_t = MSG_RES_NOTI_ATTACK_RESULT_1041(e.message).results;
					var fInfo:FightInfo = new FightInfo();
					fInfo.srcType = results.src_type;
					fInfo.srcId = results.src_id;
					fInfo.objType = results.obj_type;
					fInfo.objId = results.obj_id;
					fInfo.hpHurt = results.hp_hurt;
					dispatchEvent(new FightEvent(FightEvent.FIGHT_RESULT,fInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1042:
					var msg1041:MSG_RES_NOTI_OBJ_DEAD_1042 = e.message as MSG_RES_NOTI_OBJ_DEAD_1042;
					fInfo = new FightInfo();
					fInfo.objType = msg1041.obj_type;
					fInfo.objId = msg1041.obj_id;
					dispatchEvent(new FightEvent(FightEvent.FIGHT_DEATH,fInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1045:
					var msg1045:MSG_RES_NOTI_USER_DEAD_TYPE_1045 = e.message as MSG_RES_NOTI_USER_DEAD_TYPE_1045;
					dispatchEvent(new DeathEvent(DeathEvent.SELF_DEATH,msg1045.type,msg1045.src_id,msg1045.src_type,msg1045.money_lose,msg1045.exp_lose,msg1045.duration_type));
					break;
			}
		}
			
	}
}