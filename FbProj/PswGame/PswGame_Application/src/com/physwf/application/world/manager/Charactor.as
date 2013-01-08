package com.physwf.application.world.manager
{
	import com.physwf.application.world.controllers.CharactorController;
	import com.physwf.components.charactor.CharactorAnimation;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.vo.UserInfo;

	public class Charactor
	{
		public static var self:Charactor;
		
		private var view:CharactorAnimation;
		private var controller:CharactorController;
		private var userInfo:UserInfo;
		
		public function Charactor()
		{
		}
		
		public function initialize(userInfo:UserInfo):void
		{
			this.userInfo = userInfo;
//			self = new Charactor();
//			self.initialize(MySelf.userInfo);
			view = new CharactorAnimation();
			controller = new CharactorController(userInfo);
		}
		
		public function stand():void
		{
			
		}
		
		public function walk():void
		{
			
		}
		
		public function run():void
		{
			
		}
		
		public function attack():void
		{
			
		}
	}
}