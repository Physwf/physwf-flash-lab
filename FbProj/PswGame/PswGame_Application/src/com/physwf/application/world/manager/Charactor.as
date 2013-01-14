package com.physwf.application.world.manager
{
	import com.physwf.application.world.controllers.CharactorController;
	import com.physwf.components.charactor.CharactorAnimation;
	import com.physwf.components.charactor.enum.CharacterAction;
	import com.physwf.components.charactor.enum.ISODirection;
	import com.physwf.components.charactor.factory.BoyFactory;
	import com.physwf.components.charactor.factory.ICharacterFactory;
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
		private var mFactory:ICharacterFactory;
		private var controller:CharactorController;
		private var userInfo:UserInfo;
		
		public static var astar:IAstar;
		private var path:Vector.<Node>;
		
		private var target_x:uint;
		private var target_y:uint;
		private var speed:uint = 5;
		private var rad:Number;// 速度的方向
		private var node:Node;
		
		public function Charactor()
		{
		}
		
		public function initialize(userInfo:UserInfo):void
		{
			this.userInfo = userInfo;
			mFactory = new BoyFactory();//后期需要选择
			view = new CharactorAnimation();
			view.skeleton = mFactory.getNude();
			view.x = userInfo.map_x;
			view.y = userInfo.map_y;
			controller = new CharactorController();
			controller.initialize(view,userInfo);
		}
		
		public function goto(tx:uint,ty:uint):void
		{
			var sx:uint = Math.floor(view.x / 10);
			var sy:uint = Math.floor(view.y / 10);
			var ex:uint = tx / 10;
			var ey:uint = ty / 10;
			trace(sx,sy,"goto")
			if(astar.tryFindPath(sx,sy,ex,ey))
			{
				path = astar.getPath();
				node = path.shift();
				target_x = tx;
				target_y = ty;
				rad = Math.atan2(node.y -view.y / 10,node.x -view.x / 10);
				view.direction = ISODirection.radianToDirect(rad);
				run();
				trace(node.y ,sy,node.x ,sx,rad,"rad")
			}
		}
		
		public function stand():void
		{
			view.status = CharacterAction.ACTION_STAND;
		}
		
		public function walk():void
		{
			//切换动画状态
		}
		
		public function run():void
		{
			view.status = CharacterAction.ACTION_RUN;
		}
		
		public function attack():void
		{
			view.status = CharacterAction.ACTION_ATTACK;
		}
		
		public function update():void
		{
			if(path)
			{
//				trace(path)
				var curX:Number = view.x;
				var curY:Number = view.y;
				var speedX:Number = speed * Math.cos(rad);
				var speedY:Number = speed * Math.sin(rad);
				var offsetX:Number = (node.x * 10 - curX);
				var offsetY:Number = (node.y * 10 - curY);
				var step:Number = speedX*speedX+speedY*speedY;
				var offset:Number = offsetX*offsetX+offsetY*offsetY;
//				trace(curX,curY,node.x,node.y)
//				trace(step,offset,offsetX,offsetY)
				view.x += speedX;
				view.y += speedY;
				if(25 >= offset)// 要用绝对值
				{
					node = path.shift();
//					trace(path.length)
					if(path.length == 0) 
					{
						path = null;
//						view.x = node.x * 10;
//						view.y = node.y * 10;
						attack();
					}
					rad = Math.atan2(node.y -curY/10,node.x - curX/10);
					view.direction = ISODirection.radianToDirect(rad);
				}
				
			}
			view.update();
		}
		
		public function get userId():uint { return userInfo.uid; }
	}
}