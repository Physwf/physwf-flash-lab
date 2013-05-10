package com.physwf.engine.world.objects
{
	import com.physwf.components.charactor.CharacterAnimation;
	import com.physwf.components.charactor.factory.BoyFactory;
	import com.physwf.components.charactor.factory.ICharacterFactory;
	import com.physwf.components.effects.HeadEffect;
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.command.CmdStand;

	public class NPC extends Character
	{
		public static const STATUS_HAVE_TASK:uint = 1;//有任务
		public static const STATUS_TASK_FINISHED:uint = 2;//任务完成
		public static const STATUS_NONE:uint = 3;
		
		public var nid:uint;
		public var name:String;
		private var mResouceID:uint;
		
		private var scriptID:uint;
		
		public function NPC()
		{
			super();
		}
		
		public function initialize():void
		{
			view = new CharacterAnimation();
			var mFactory:ICharacterFactory = new BoyFactory();//后期需要根据用户信息进行选择
			view.skeleton = mFactory.getNude();
			
			mHeadEffect = new HeadEffect(Engine.map.view.upperEffect,0,null,view);
			
			Character.managers[view] = this;
			
			execute(new CmdStand(this));
		}
		/**
		 *加载npc脚本，npc脚本主要用来实现NPC同用户的状态或者用户的操作进行交互逻辑
		 * 
		 */		
		public function loadScirpt():void
		{
			
		}
		
	}
}