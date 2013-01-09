package com.physwf.application.world.manager
{
	import com.physwf.application.world.controllers.CharactorController;
	import com.physwf.components.charactor.CharactorAnimation;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.wayfinding.astar.BiHeapAStar;
	import com.physwf.components.map.wayfinding.astar.IAstar;
	import com.physwf.components.map.wayfinding.astar.Node;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.vo.UserInfo;
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class Charactor extends EventDispatcher implements IUpdatable
	{
		public static var self:Charactor;
		
		public var view:CharactorAnimation;
		private var controller:CharactorController;
		private var userInfo:UserInfo;
		
		public static var astar:IAstar;
		private var path:Vector.<Node>;
		
		private var target_x:uint;
		private var target_y:uint;
		private var speed:uint = 5;
		private var rad:Number;// 速度的方向
		
		public function Charactor()
		{
		}
		
		public function initialize(userInfo:UserInfo):void
		{
			this.userInfo = userInfo;
			
			view = new CharactorAnimation();
			view.x = userInfo.map_x;
			view.y = userInfo.map_y;
			controller = new CharactorController();
			controller.initialize(view,userInfo);
			
			astar = new BiHeapAStar();
		}
		
		public function goto(tx:uint,ty:uint):void
		{
			if(astar.tryFindPath(view.x,view.y,tx,tx))
			{
				path = astar.getPath();
				target_x = tx;
				target_y = ty;
				rad = Math.atan2(path[0].y -view.y,path[0].x -view.x);
			}
		}
		
		public function stand():void
		{
			//切换动画状态
		}
		
		public function walk():void
		{
			//切换动画状态
		}
		
		public function run():void
		{
			//切换动画状态
		}
		
		public function attack():void
		{
			//切换动画状态
		}
		
		public function update():void
		{
			if(path)
			{
				var curX:Number = view.x;
				var curY:Number = view.y;
				var node:Node = path[0];
				var speedX:Number = speed * Math.cos(rad);
				var speedY:Number = speed * Math.sin(rad);
				if(curX+speedX > node.x * 10 && curY+speedY > node.y * 10)
				{
					path.shift();
					if(path.length == 0) 
					{
						path = null;
					}
					rad = Math.atan2(node.y -curY,node.x - curX);
				}
				view.x += speedX;
				view.y += speedY;
			}
			view.update();
		}
		
		public function get userId():uint { return userInfo.uid; }
	}
}