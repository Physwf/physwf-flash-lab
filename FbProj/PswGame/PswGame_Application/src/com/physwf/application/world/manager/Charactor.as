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
		private var speed:uint = 3;
		private var rad:Number;// 速度的方向
		private var node:Node;
		
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
		}
		
		public function goto(tx:uint,ty:uint):void
		{
			var sx:uint = view.x / 10;
			var sy:uint = view.y / 10;
			var ex:uint = tx / 10;
			var ey:uint = ty / 10;
			trace(sx,sy,"goto")
			if(astar.tryFindPath(sx,sy,ex,ey))
			{
				path = astar.getPath();
				path.shift();
				node = path.shift();
				target_x = tx;
				target_y = ty;
				rad = Math.atan2(node.y -sy,node.x -sx);
				trace(node.y ,sy,node.x ,sx,rad,"rad")
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
				trace(path)
				var curX:Number = view.x;
				var curY:Number = view.y;
				var speedX:Number = speed * Math.cos(rad);
				var speedY:Number = speed * Math.sin(rad);
//				if(curX+speedX >= node.x * 10 && curY+speedY >= node.y * 10)// 要用绝对值
				var offsetX:Number = (node.x * 10 - curX);
				var offsetY:Number = (node.y * 10 - curY);
				var step:Number = speedX*speedX+speedY*speedY;
				var offset:Number = offsetX*offsetX+offsetY*offsetY;
//				trace(step,offset)
				if(9 >= offset)// 要用绝对值
				{
					node = path.shift();
					trace(path.length)
					if(path.length == 0) 
					{
						path = null;
					}
					rad = Math.atan2(node.y -curY/10,node.x - curX/10);
				}
				view.x += speedX;
				view.y += speedY;
			}
			view.update();
		}
		
		public function get userId():uint { return userInfo.uid; }
	}
}