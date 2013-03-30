package com.physwf.engine.world.objects
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.view.Animation;
	import com.physwf.system.System;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Teleport implements IUpdatable
	{
		public static var teleports:Vector.<Teleport>;
		private static var timer:Timer;
		private var mX:uint;
		private var mY:uint;
		private var mToMap:uint;//传送到的地图id
		private var mToMapX:uint;
		private var mToMapY:uint;
		
		private static const radius:uint = 30;
		
		private var mView:Animation;
		
		public function Teleport()// to do 传入传送点信息结构体
		{
			mView = new Animation();
			// to do 加载动画
		}
		
		public static function initialize():void
		{
			teleports = new Vector.<Teleport>();
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
		}
		
		private static function onTimer(e:TimerEvent):void
		{
			for(var i:uint=0;i<teleports.length;++i)
			{
				var distX:int = Player.self.view.x - teleports[i].mX;
				var distY:int = Player.self.view.y - teleports[i].mY;
				
				if(distX * distX + distY * distY < radius * radius)
				{
					timer.stop();
					System.myself.enterMap(teleports[i].mToMap,teleports[i].mToMapX,teleports[i].mToMapY);
					break;
				}
			}
		}
		
		/**
		 * 传入传送点信息列表作为参数 
		 * 
		 */		
		public static function setMapTeleports():void
		{
			// to do 销毁 + 新建
			timer.start();
		}
		
		public function update():void
		{
			mView.update();
		}
	}
}