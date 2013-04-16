package com.physwf.engine.common.command
{
	import com.physwf.components.command.Command;
	import com.physwf.components.effects.Effect;
	import com.physwf.components.effects.EffectConfig;
	import com.physwf.components.effects.IEffectFactory;
	import com.physwf.config.Config;
	import com.physwf.engine.Engine;
	import com.physwf.engine.fight.Fight;
	import com.physwf.engine.fight.effects.EffectSystem;
	import com.physwf.engine.world.objects.Character;
	import com.physwf.engine.world.objects.Player;
	import com.physwf.system.System;
	
	import flash.events.Event;

	/**
	 * 多体，根据技能等情况选择多个玩家（有上限）进行攻击 
	 * @author joe
	 * 
	 */	
	public class CmdMultiAtk extends CmdAttack
	{
		private var mTargets:Vector.<Character>;
		
		public function CmdMultiAtk(chara:Character)
		{
			super(chara);
		}
		
		public function setTargets(tgts:Vector.<Character>):void
		{
			mTargets = tgts;
		}
		
		override public function execute():void
		{
			var skillID:uint = mSkill.id;
			var type:uint = Config.getEffectConfig(mSkill.effectId).type;
			var config:EffectConfig = EffectSystem.getConfig(mSkill.effectId);
			trace("type=",type,"effectId",mSkill.effectId);
			var factory:IEffectFactory = EffectSystem.getFactory(type);
			for(var i:uint=0;i<mTargets.length;++i)
			{
				var effect:Effect = factory.createEffect(config,Engine.map.view.upperEffect,mChara.view,mTargets[i].view);
				effect.x = mChara.view.x;
				effect.y = mChara.view.y - 30;
			}
			mChara.attack();
			if(mChara == Player.self)
			{
//				System.fight.attack(Fight.FIGHT_CHARA_TYPE_PLAYER,Fight.FIGHT_CHARA_TYPE_NPC,mTarget.id,skillID);
			}
			super.execute();
			dispatchEvent(new Event(FINISH));
		}
	}
}