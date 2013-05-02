package com.physwf.engine.world.controllers
{
	import com.physwf.components.charactor.CharacterAnimation;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.engine.world.objects.Character;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.vo.UserInfo;
	
	import flash.utils.getTimer;

	public class SelfController implements IUpdatable
	{
		private var chara:Character;
		private var userInfo:UserInfo;
		
		private var lastSyncTime:uint;//上一次同步的时间
		private var syncInterval:uint = 1000;//更新间隔，ms
		
		public function SelfController()
		{
			
		}
		
		public function initialize(chara:Character,userInfo:UserInfo):void
		{
			this.chara = chara;
			this.userInfo = userInfo;
		}
		
		public function update():void
		{
			var curTime:uint = getTimer();
			if(chara.isMoving)
			{
				if(curTime - lastSyncTime >= syncInterval)
				{
					lastSyncTime = curTime;
					System.myself.syncPosition(chara.view.x,chara.view.y);
//					trace("sync pos",lastSyncTime);
				}
			}
		}
	}
}