package com.physwf.system.entity
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.events.DeathEvent;
	import com.physwf.system.events.FightEvent;
	import com.physwf.system.vo.FightInfo;
	import com.physwf.system.vo.FightObject;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class FightSystem extends EventDispatcher
	{
		public function FightSystem()
		{
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1040,onFightMessage);//战斗攻击
		}
		
		public function onMapSwitchStart():void
		{
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1041,onFightMessage);//战斗结果
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1042,onFightMessage);//目标被打死
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1045,onFightMessage);//通知玩家死亡类型
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1047,onFightMessage);//通知buff
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1048,onFightMessage);//根据位置攻击，放置陷阱
			
			RPCConnectioin.online.removeEventListener(MessageEvent.MSG_SUCCESS_+1123,onFightMessage);//设置技能吟唱开始时间
		}
		
		public function onMapSwitchEnd():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1041,onFightMessage);//战斗结果
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1042,onFightMessage);//目标被打死
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1045,onFightMessage);//通知玩家死亡类型
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1047,onFightMessage);//通知buff
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1048,onFightMessage);//根据位置攻击，放置陷阱
			
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1123,onFightMessage);//设置技能吟唱开始时间
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
		
		public function attackByPos(skillId:uint,mapX:uint,mapY:uint):void
		{
			var msg:MSG_REQ_ATTACK_BY_POS_1048 = new MSG_REQ_ATTACK_BY_POS_1048();
			msg.skill_id = skillId;
			msg.map_x = mapX;
			msg.map_y = mapY;
			RPCConnectioin.online.call(msg);
		}
		
		public function chant(skillId:uint):void
		{
			var msg:MSG_REQ_SET_SKILL_CHANT_1123 = new MSG_REQ_SET_SKILL_CHANT_1123();
			msg.skill_id = skillId;
			RPCConnectioin.online.call(msg);
		}
		
		private function onFightMessage(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1040:
					break;
				case MessageEvent.MSG_SUCCESS_+1041://战斗结果
					var results:atk_result_t = MSG_RES_NOTI_ATTACK_RESULT_1041(e.message).results;
					var fInfo:FightInfo = new FightInfo();
					fInfo.srcType = results.src_type;
					fInfo.srcId = results.src_id;
					var objs:Vector.<btl_obj_t> = results.objs;
					var fObjs:Vector.<FightObject> = new Vector.<FightObject>();
					for(var i:uint=0;i<objs.length;++i)
					{
						var fObj:FightObject = new FightObject();
						fObj.type = objs[i].obj_type;
						fObj.id = objs[i].obj_id;
						fObj.hp = objs[i].obj_hp;
						fObj.mp = objs[i].obj_mp;
						fObjs.push(fObj);
					}
					fInfo.objects = fObjs;
					dispatchEvent(new FightEvent(FightEvent.FIGHT_RESULT,fInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1042://目标被打死
					var msg1041:MSG_RES_NOTI_OBJ_DEAD_1042 = e.message as MSG_RES_NOTI_OBJ_DEAD_1042;
					fInfo = new FightInfo();
					fObjs = new Vector.<FightObject>();
					fObj = new FightObject();
					fObj.type = msg1041.obj_type;
					fObj.id = msg1041.obj_id;
					fObjs.push(fObj);
					fInfo.objects = fObjs;
					dispatchEvent(new FightEvent(FightEvent.FIGHT_DEATH,fInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1045://通知玩家死亡类型
					var msg1045:MSG_RES_NOTI_USER_DEAD_TYPE_1045 = e.message as MSG_RES_NOTI_USER_DEAD_TYPE_1045;
					dispatchEvent(new DeathEvent(DeathEvent.SELF_DEATH,msg1045.type,msg1045.src_id,msg1045.src_type,msg1045.money_lose,msg1045.exp_lose,msg1045.duration_type));
					break;
				case MessageEvent.MSG_SUCCESS_+1047://通知buff
					
					break;
				case MessageEvent.MSG_SUCCESS_+1048://根据位置攻击，放置陷阱
					
					break;
				case MessageEvent.MSG_SUCCESS_+1123://设置技能吟唱开始时间
					break;
			}
		}
			
	}
}