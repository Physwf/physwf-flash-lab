package com.physwf.engine.common.command
{
	import com.physwf.components.command.Command;
	import com.physwf.engine.world.objects.Character;
	import com.physwf.system.vo.SkillInfo;
	
	import flash.events.Event;
	import flash.utils.getTimer;

	/**
	 * 所有攻击类的子类 
	 * @author joe
	 */
	public class CmdAttack extends Command
	{
		protected var mChara:Character;
		protected var mSkill:SkillInfo;
		protected var mStartTime:uint;
		
		public function CmdAttack(chara:Character)
		{
			mChara = chara;
		}
		
		public function set skill(v:SkillInfo):void
		{
			mSkill = v;
		}
		
		override public function execute():void
		{
			mStartTime = getTimer();
		}
		
		override public function update():void
		{
			// to do
			//角色动画 吟唱 通道的进度等
			if(getTimer() - mStartTime > 800)//暂定
			{
				dispatchEvent(new Event(Command.FINISH));
			}
		}
	}
}