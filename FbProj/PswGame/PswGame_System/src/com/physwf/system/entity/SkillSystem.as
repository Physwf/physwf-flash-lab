package com.physwf.system.entity
{
	import com.physwf.system.vo.SkillInfo;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class SkillSystem extends EventDispatcher
	{
		private var mSkillsInBar:Vector.<SkillInfo>;
		
		public function SkillSystem()
		{
			mSkillsInBar = new Vector.<SkillInfo>();
			for(var i:int=0;i<8;++i)
			{
				var skill:SkillInfo = new SkillInfo();
				skill.id = i;
				skill.name = "";
				mSkillsInBar.push(skill);
			}
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