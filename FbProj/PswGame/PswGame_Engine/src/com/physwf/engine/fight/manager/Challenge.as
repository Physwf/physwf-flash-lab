package com.physwf.engine.fight.manager
{
	import com.physwf.components.charactor.BloodBar;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.engine.Engine;
	import com.physwf.engine.fight.Fight;
	import com.physwf.engine.fight.controller.ChallengeController;
	import com.physwf.engine.world.manager.Character;
	import com.physwf.system.System;
	import com.physwf.system.entity.FightSystem;
	import com.physwf.system.events.FightEvent;
	import com.physwf.system.vo.FightInfo;
	
	public class Challenge implements IUpdatable
	{
		public var target:Character;
		private var controller:ChallengeController;
		
		public function Challenge()
		{
		}
		
		public function initialize():void
		{
			System.fight.addEventListener(FightEvent.FIGHT_RESULT,onFightEvent);
			System.fight.addEventListener(FightEvent.FIGHT_DEATH,onFightEvent);
			controller = new ChallengeController();
			controller.initialize(this);
		}
		
		private function onFightEvent(e:FightEvent):void
		{
			switch(e.type)
			{
				case FightEvent.FIGHT_RESULT:
					var infos:Vector.<FightInfo> = e.infos;
					for(var i:int=0;i<infos.length;++i)
					{
						var chara:Character = getCharacterByID(infos[i].objType,infos[i].objId);
						if(chara)
						{
							chara.run();
						}
					}
					break;
				case FightEvent.FIGHT_DEATH:
					var info:FightInfo = e.infos[0];//目前只返回一个结果
					chara = getCharacterByID(info.objType,info.objId);
					if(chara)
					{
						chara.die();
					}
					break;
			}
		}
		
		private function getCharacterByID(type:uint,id:uint):Character
		{
			if(type == Fight.FIGHT_CHARA_TYPE_PLAYER)
			{
				return Engine.map.getPlayerByUID(id);
			}
			else if(type == Fight.FIGHT_CHARA_TYPE_PET)
			{
				return null;
			}
			else if(type == Fight.FIGHT_CHARA_TYPE_NPC)
			{
				Engine.map.getMonsterByMID(id);
			}
			return null;
		}
		
		public function setTarget(tgt:Character):void
		{
			target = tgt;
			if(target)
			{
				var bb:BloodBar = new BloodBar();
				bb.x = -bb.width * .5;
				target.view.specialLayer.addChild(bb);
			}
		}
		
		public function update():void
		{
		}
	}
}