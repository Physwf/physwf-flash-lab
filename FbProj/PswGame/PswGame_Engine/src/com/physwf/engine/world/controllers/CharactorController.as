package com.physwf.engine.world.controllers
{
	import com.physwf.components.charactor.CharacterAnimation;
	import com.physwf.system.vo.UserInfo;

	public class CharactorController
	{
		private var view:CharacterAnimation;
		private var userInfo:UserInfo;
		
		public function CharactorController()
		{
			
		}
		
		public function initialize(view:CharacterAnimation,userInfo:UserInfo):void
		{
			this.view = view;
			this.userInfo = userInfo;
		}
	}
}