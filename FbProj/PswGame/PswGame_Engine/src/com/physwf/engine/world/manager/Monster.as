package com.physwf.engine.world.manager
{
	import com.physwf.components.charactor.CharacterAnimation;
	import com.physwf.components.charactor.enum.AnimationSystem;
	import com.physwf.components.charactor.enum.ISODirection;
	import com.physwf.components.charactor.factory.ICharacterFactory;
	import com.physwf.components.charactor.factory.MonsterFactory;
	import com.physwf.system.vo.MonsterInfo;

	public class Monster extends Character
	{
		private var mInfo:MonsterInfo;
		private var mInstanceId:uint;
		
		private var mFactory:ICharacterFactory;
		
		public function Monster()
		{
		}
		
		public function initialize(info:MonsterInfo):void
		{
			mInfo = info;
			mInstanceId = info.id;
			// 
			view = new CharacterAnimation(AnimationSystem.MOLE);
			mFactory = new MonsterFactory();
			view.skeleton = mFactory.getWear(1);
//			view.direction = ISODirection.LEFT;
			view.x = info.map_x;
			view.y = info.map_y;
			
			Character.managers[view] = this;
		}
		
		public function get instanId():uint { return mInstanceId; }
	}
}