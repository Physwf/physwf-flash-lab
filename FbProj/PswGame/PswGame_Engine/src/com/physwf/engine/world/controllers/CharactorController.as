package com.physwf.engine.world.controllers
{
	import com.physwf.components.charactor.CharactorAnimation;
	import com.physwf.system.vo.UserInfo;

	public class CharactorController
	{
		private var view:CharactorAnimation;
		private var userInfo:UserInfo;
		
		public function CharactorController()
		{
			
		}
		
		public function initialize(view:CharactorAnimation,userInfo:UserInfo):void
		{
			this.view = view;
			this.userInfo = userInfo;
		}
	}
}