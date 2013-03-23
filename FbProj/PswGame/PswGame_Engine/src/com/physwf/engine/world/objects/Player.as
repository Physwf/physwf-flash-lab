package com.physwf.engine.world.objects
{
	import com.physwf.components.charactor.CharacterAnimation;
	import com.physwf.components.charactor.factory.BoyFactory;
	import com.physwf.components.charactor.factory.ICharacterFactory;
	import com.physwf.components.effects.HeadEffect;
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.command.CmdStand;
	import com.physwf.engine.world.controllers.SelfController;
	import com.physwf.system.vo.UserInfo;

	public class Player extends Character
	{
		public static var self:Player;
		
		private var userInfo:UserInfo;
		private var uid:uint;//为了访问方便及效率考虑，将uid单独作为一个字段
		
		private var mFactory:ICharacterFactory;
		public static var controller:SelfController;
		
		public function Player()
		{
			super();
		}
		
		public function initialize(userInfo:UserInfo):void
		{
			this.userInfo = userInfo;
			uid = userInfo.uid;
			mFactory = new BoyFactory();//后期需要根据用户信息进行选择
			view = new CharacterAnimation();
			view.skeleton = mFactory.getNude();
			view.x = userInfo.map_x;
			view.y = userInfo.map_y;
			
			Character.managers[view] = this;
			
			mHeadEffect = new HeadEffect(Engine.map.view.upperEffect,0,null,view);
			mHeadEffect.update();//刷新位置
			mHeadEffect.setName(userInfo.nick);
			
			execute(new CmdStand(this));
		}
		
		override public function destroy():void
		{
			mHeadEffect.destroy();
			super.destroy();
		}
		
		override public function get id():uint { return uid; }
		public function get info():UserInfo { return userInfo; }
	}
}