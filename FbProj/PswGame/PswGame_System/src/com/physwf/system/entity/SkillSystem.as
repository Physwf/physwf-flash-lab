package com.physwf.system.entity
{
	import com.physwf.system.vo.SkillInfo;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class SkillSystem extends EventDispatcher
	{
		public var basicSill:SkillInfo;//基础技能，当没有为角色选择攻击技能时，默认使用基础技能
		
		public var skills:Vector.<SkillInfo>;
		
		public function SkillSystem()
		{
			
		}
		
		public function initialize():void
		{
			basicSill = new SkillInfo();
			basicSill.id = 100;
		}
	}
}