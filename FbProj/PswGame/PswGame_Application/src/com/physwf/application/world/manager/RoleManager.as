package com.physwf.application.world.manager
{
	import com.physwf.application.world.controllers.RoleController;
	import com.physwf.components.charactor.Charactor;

	public class RoleManager
	{
		public static var self:Charactor;
		private static var selfCtl:RoleController;
		
		public function RoleManager()
		{
		}
		
		public function initialize():void
		{
			self = new Charactor();
			selfCtl = new RoleController();
		}
	}
}