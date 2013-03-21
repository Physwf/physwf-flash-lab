package com.physwf.engine.command
{
	import com.physwf.components.command.Command;
	import com.physwf.components.effects.HurtEffect;
	import com.physwf.engine.Engine;
	import com.physwf.engine.fight.effects.EffectSystem;
	import com.physwf.engine.world.manager.Character;
	import com.physwf.system.vo.SkillInfo;
	
	import flash.events.Event;
	import flash.utils.getTimer;

	/**
	 *  
	 * @author joe
	 * 
	 */	
	public class CmdOnHurt extends Command
	{
		private var mChara:Character;
		private var mHpLoss:uint;
		private var mSkill:SkillInfo;
		private var mStartTime:uint;
		
		public function CmdOnHurt(chara:Character)
		{
			mChara = chara;
		}
		
		public function setHurt(hpLoss:uint,skill:SkillInfo):void
		{
			mHpLoss = hpLoss;
			mSkill = skill;
		}
		
		override public function execute():void
		{
			var hurtEff:HurtEffect = new HurtEffect(Engine.map.view.upperEffect,1000,null,mChara.view);
			hurtEff.setHurt(mHpLoss,EffectSystem.DIR_TEXT+EffectSystem.STYLE_COOPER);
			mStartTime = getTimer();
		}
		
		override public function update():void
		{
			if(getTimer() - mStartTime > 1000)//暂定
			{
				dispatchEvent(new Event(Command.FINISH));
			}
		}
	}
}