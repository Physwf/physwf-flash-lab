package com.physwf.engine.world.manager
{
	import com.physwf.components.charactor.CharactorAnimation;
	import com.physwf.components.charactor.factory.BoyFactory;
	import com.physwf.components.charactor.factory.ICharacterFactory;
	import com.physwf.engine.world.controllers.CharactorController;
	import com.physwf.system.vo.UserInfo;

	public class Player extends Character
	{
		public static var self:Player;
		
		private var userInfo:UserInfo;
		private var uid:uint;//为了访问方便及效率考虑，将uid单独作为一个字段
		
		private var mFactory:ICharacterFactory;
		private var controller:CharactorController;
		
		public function Player()
		{
			super();
		}
		
		public function initialize(userInfo:UserInfo):void
		{
			this.userInfo = userInfo;
			uid = userInfo.uid;
			mFactory = new BoyFactory();//后期需要根据用户信息进行选择
			view = new CharactorAnimation();
			view.skeleton = mFactory.getNude();
			view.x = userInfo.map_x;
			view.y = userInfo.map_y;
			// 只有self 才需要controller
			controller = new CharactorController();
			controller.initialize(view,userInfo);
		}
		
		public function get userId():uint { return uid; }
	}
}