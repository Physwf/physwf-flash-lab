package com.physwf.application.startup
{
	import com.physwf.application.interfaces.IDestroyable;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;

	public class Startup implements IDestroyable
	{
		public function Startup()
		{
		}
		
		public function initialize():void
		{
			System.initialize();
			var ip:Object = {host:MySelf.loginInfo.serverInfo.ip,port:MySelf.loginInfo.serverInfo.port};
			System.estabConnection(ip,onConect);
		}
		
		private function onConect():void
		{
			System.myself.login();
		}
		
		public function dispose():void
		{
			
		}
	}
}