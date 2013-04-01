package com.physwf.system.entity
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.events.SkillEvent;
	import com.physwf.system.vo.SkillInfo;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class SkillSystem extends EventDispatcher
	{
		public var basicSill:SkillInfo;//基础技能，当没有为角色选择攻击技能时，默认使用基础技能
		
		public var skills:Vector.<SkillInfo>;
		public var shortcutSkill:Vector.<uint>;//快捷栏技能 共10个
		
		public function SkillSystem()
		{
			
		}
		
		public function initialize():void
		{
			basicSill = new SkillInfo();
			basicSill.id = 100;
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1120,onMessage);//技能学习(添加技能)
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1121,onMessage);//技能升级
		}
		/**
		 * 技能学习 
		 * @param id
		 */		
		public function learnSkill(id:uint):void
		{
			var msg:MSG_REQ_ADD_SKILL_1120 = new MSG_REQ_ADD_SKILL_1120();
			msg.skill_id = id;
			RPCConnectioin.online.call(msg);
		}
		/**
		 * 技能升级 
		 * @param id
		 */		
		public function upgradeSkill(id:uint):void
		{
			var msg:MSG_REQ_UPGRADE_SKILL_1121 = new MSG_REQ_UPGRADE_SKILL_1121();
			msg.skill_id = id;
			RPCConnectioin.online.call(msg);
		}
		
		private function onMessage(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1120://技能学习(添加技能)
					var msg1120:MSG_RES_ADD_SKILL_1120 = e.message as MSG_RES_ADD_SKILL_1120;
					var skill:SkillInfo = new SkillInfo();
					skill.id = msg1120.skill.skill_id;
					skill.level = msg1120.skill.skill_lv;
					dispatchEvent(new SkillEvent(SkillEvent.SKILL_LEARNED,skill));
					break;
				case MessageEvent.MSG_SUCCESS_+1021://技能升级
					var msg1021:MSG_RES_UPGRADE_SKILL_1121 = e.message as MSG_RES_UPGRADE_SKILL_1121;
					skill = getSkillById(msg1021.skill.skill_id);
					skill.level = msg1021.skill.skill_lv;
					dispatchEvent(new SkillEvent(SkillEvent.SKILL_UPGRADE,skill));
					break;
			}
		}
		
		public function getSkillById(sid:uint):SkillInfo
		{
			for(var i:uint=0;i<skills.length;++i)
			{
				if(skills[i].id == sid)
				{
					return skills[i];
				}
			}
			return null;
		}
	}
}