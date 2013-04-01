package com.physwf.engine.world.objects
{
	import com.physwf.components.charactor.CharacterAnimation;
	import com.physwf.components.charactor.enum.AnimationSystem;
	import com.physwf.components.charactor.enum.ISODirection;
	import com.physwf.components.charactor.factory.ICharacterFactory;
	import com.physwf.components.charactor.factory.MonsterFactory;
	import com.physwf.components.effects.HeadEffect;
	import com.physwf.config.ConfigReader;
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.command.CmdStand;
	import com.physwf.system.vo.MonsterInfo;

	public class Monster extends Character
	{
		private var mInfo:MonsterInfo;
		private var mInstanceId:uint;
		
		private var mFactory:ICharacterFactory;
		
		public function Monster()
		{
			super();
		}
		
		public function initialize(info:MonsterInfo):void
		{
			mInfo = info;
			mInstanceId = info.instanceID;
			
			ConfigReader.readMonster(mInfo);
			// 
			view = new CharacterAnimation(AnimationSystem.AOTM);
			mFactory = new MonsterFactory();
			view.skeleton = mFactory.getWear(2);
			
			view.x = info.map_x;
			view.y = info.map_y;
			
			Character.managers[view] = this;
			
			mHeadEffect = new HeadEffect(Engine.map.view.upperEffect,0,null,view);
			
			execute(new CmdStand(this));
		}
		
		override public function get id():uint { return mInstanceId; }
		public function get info():MonsterInfo { return mInfo; }
	}
}