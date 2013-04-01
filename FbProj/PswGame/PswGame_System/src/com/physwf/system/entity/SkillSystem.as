package com.physwf.system.entity
{
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