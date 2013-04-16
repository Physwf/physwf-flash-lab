package com.physwf.engine.fight.manager
{
	import com.physwf.components.command.Command;
	import com.physwf.components.command.CommandSequence;
	import com.physwf.components.command.ICommand;
	import com.physwf.components.command.LinerCmdSequence;
	import com.physwf.components.effects.TargetEffect;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.command.CmdGoToForAttack;
	import com.physwf.engine.common.command.CmdOnHurt;
	import com.physwf.engine.common.command.CmdSingleAtk;
	import com.physwf.engine.common.command.CmdStand;
	import com.physwf.engine.common.events.CharacterEvent;
	import com.physwf.engine.fight.Fight;
	import com.physwf.engine.fight.controller.ChallengeController;
	import com.physwf.engine.world.objects.Character;
	import com.physwf.engine.world.objects.Monster;
	import com.physwf.engine.world.objects.Player;
	import com.physwf.system.System;
	import com.physwf.system.events.DeathEvent;
	import com.physwf.system.events.FightEvent;
	import com.physwf.system.vo.FightInfo;
	import com.physwf.system.vo.FightObject;
	import com.physwf.system.vo.MonsterInfo;
	import com.physwf.system.vo.SkillInfo;
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	public class Challenge extends EventDispatcher implements IUpdatable
	{
		public var target:Character;//选中的目标
		public var targets:Vector.<Character>;
		
		public var basicSkill:SkillInfo;//基础技能
		public var selectSill:SkillInfo;//点击技能栏选择的技能
		
		public static var targetEffect:TargetEffect;
		
		private var targetID:uint = 0;
		private var controller:ChallengeController;
		private var lastAtk:uint = 0;
		private var isIdle:Boolean = true;
		
		public function Challenge()
		{
			Engine.challenge = this;
		}
		
		public function initialize():void
		{
			controller = new ChallengeController();
			controller.initialize(this);
		}
		
		public function onWorldDestroy():void
		{
			System.fight.removeEventListener(DeathEvent.SELF_DEATH,onDeathEvent);//temp
		}
		
		public function onWorldReady():void
		{
			System.fight.addEventListener(DeathEvent.SELF_DEATH,onDeathEvent);//temp
		}
		
		private function onDeathEvent(e:DeathEvent):void
		{
			switch(e.type)
			{
				case DeathEvent.SELF_DEATH:
					//temp
					break;
			}
		}
		
		public function setTarget(tgt:Character,id:uint):void
		{
			target = tgt;
			targetID = id;
		}
		
		public function setTargets(tgts:Vector.<Character>):void
		{
			targets = tgts;
		}
		
		private function getCmd(tgt:Character,id:uint):ICommand
		{
			var distX:Number = target.view.x - Player.self.view.x;
			var distY:Number = target.view.y - Player.self.view.y;
			var rad:Number = Math.atan2(distY,distX);
			var skills:Vector.<SkillInfo> = System.skill.skills;
			var random:uint = Math.random() * skills.length;
			var skill:SkillInfo = skills[random];
//			trace(skill,skill.id,"skill");
			var attack:CmdSingleAtk = new CmdSingleAtk(Player.self);
			attack.setTarget(tgt);
			attack.skill = skill;
			
			attack.addEventListener(Command.FINISH,onAttack);
			
			var seq:LinerCmdSequence = new LinerCmdSequence();
			var secureRange:uint = skill.range - 15;//保险范围，
			if((distX * distX + distY * distY) > (skill.range * skill.range))
			{
				var walkCmd:CmdGoToForAttack = new CmdGoToForAttack(Player.self);
				walkCmd.setDest(tgt.view.x,tgt.view.y);
				walkCmd.setSkill(skill);
				seq.addCommand(walkCmd);
			}
			seq.addCommand(attack);
			seq.addCommand(new CmdStand(Player.self));
			seq.addEventListener(Command.FINISH,onSeqFinish);
			return seq;
		}
		
		private function onAttack(e:Event):void
		{
			var cmd:Command = e.target as Command;
			cmd.removeEventListener(Command.FINISH,onAttack);
			lastAtk = getTimer();
		}
		
		private function onSeqFinish(e:Event):void
		{
			var seq:CommandSequence = e.target as CommandSequence;
			seq.removeEventListener(Command.FINISH,onSeqFinish);
			isIdle = true;
			trace("seq finish",getTimer());
		}
		
		public function update():void
		{
			if(target && isIdle)
			{
				if(getTimer() - lastAtk > 2000)
				{
					
					isIdle = false;
					var cmd:ICommand = getCmd(target,targetID);
					Player.self.execute(cmd);
					trace("cmd exe",getTimer());
				}
			}
		}
	}
}