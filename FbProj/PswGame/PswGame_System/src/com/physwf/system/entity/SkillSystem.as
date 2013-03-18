package com.physwf.system.entity
{
	import com.physwf.system.vo.SkillInfo;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class SkillSystem extends EventDispatcher
	{
		public var basicSill:SkillInfo;//基础技能，当没有为角色选择攻击技能时，默认使用基础技能
		
		private var mSkillsInBar:Vector.<SkillInfo>;
		
		public function SkillSystem()
		{
			mSkillsInBar = new Vector.<SkillInfo>();
			for(var i:int=0;i<8;++i)
			{
				var skill:SkillInfo = new SkillInfo();
				skill.id = i;
				skill.name = "";
				skill.range = 500 + i*10;
				skill.effectId = i;
				mSkillsInBar.push(skill);
			}
			basicSill = mSkillsInBar[0];
		}
		
		public function initialize():void
		{
			
		}
		
		public function getSkillsInBar():Vector.<SkillInfo>
		{
			return mSkillsInBar;
		}
	}
}