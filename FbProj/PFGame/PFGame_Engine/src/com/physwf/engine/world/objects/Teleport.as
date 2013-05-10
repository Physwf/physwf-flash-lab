package com.physwf.engine.world.objects
{
	import com.physwf.components.bitmap.net.SkeletonLoader;
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.view.Animation;
	import com.physwf.engine.Engine;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.getClassByAlias;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	public class Teleport implements IUpdatable,IDisposible
	{
		public static var teleports:Vector.<Teleport>;
		private static var timer:Timer;
		private var mX:uint;
		private var mY:uint;
		private var mToMap:uint;//传送到的地图id
		private var mToMapX:uint;
		private var mToMapY:uint;
		
		private static const radius:uint = 30;
		
		public var view:Animation;
		
		private var time:uint;
		private var mPos:Point;
		public function Teleport()// to do 传入传送点信息结构体
		{
			var skeleton:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("resource/objects/teleport");
			view = new Animation(skeleton);
			view.gotoAndPlay("1");
			time = getTimer();
			// to do 加载动画
		}
		
		public function update():void
		{
			view.update();
			var now:uint = getTimer();
			if(now - time >= 1000)
			{
				var selfPos:Point = new Point(Player.self.view.x,Player.self.view.y);
				var tPos:Point = new Point(view.x,view.y);
				if(Point.distance(selfPos,tPos)<=100)
				{
					var curMap:uint = MySelf.userInfo.map_id;
					var nextMapId:uint = curMap==1?2:1;//temp
					var nextPos:Point;
					if(nextMapId==1)
					{
						nextPos = new Point(800,360);
					}
					else
					{
						nextPos = new Point(800,500);
					}
					Engine.world.switchMap(nextMapId,nextPos.x,nextPos.y);
				}
				time = now;
			}
		}
		
		public function destroy():void
		{
			view.destroy();
			view = null;
		}
	}
}