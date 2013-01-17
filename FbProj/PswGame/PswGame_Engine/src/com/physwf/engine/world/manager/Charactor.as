package com.physwf.engine.world.manager
{
	import com.physwf.components.charactor.CharactorAnimation;
	import com.physwf.components.charactor.enum.CharacterAction;
	import com.physwf.components.charactor.enum.ISODirection;
	import com.physwf.components.charactor.factory.BoyFactory;
	import com.physwf.components.charactor.factory.ICharacterFactory;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.wayfinding.astar.IAstar;
	import com.physwf.components.map.wayfinding.astar.Line;
	import com.physwf.components.map.wayfinding.astar.Node;
	import com.physwf.components.map.wayfinding.astar.PathUtils;
	import com.physwf.engine.world.controllers.CharactorController;
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.EventDispatcher;

	public class Charactor extends EventDispatcher implements IUpdatable
	{
		public static var self:Charactor;
		
		public var view:CharactorAnimation;
		private var mFactory:ICharacterFactory;
		private var controller:CharactorController;
		private var userInfo:UserInfo;
		private var uid:uint;
		
		public static var astar:IAstar;
//		private var path:Vector.<Node>;
		private var pathLine:Vector.<Line>;
		
		private var target_x:uint;
		private var target_y:uint;
		private var speed:uint = 6;
		private var rad:Number;// 速度的方向
		private var avrgRad:Number;//路径的方向（取前面若干个点的方向平均）
//		private var node:Node;
		private var line:Line;
		
		public function Charactor()
		{
		}
		
		public function initialize(userInfo:UserInfo):void
		{
			this.userInfo = userInfo;
			uid = userInfo.uid;
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
			var ex:uint = Math.floor(tx / 10);
			var ey:uint = Math.floor(ty / 10);
			trace(sx,sy,"goto")
			if(astar.tryFindPath(sx,sy,ex,ey))
			{
				pathLine = astar.getPathLine();
				
				line = pathLine.shift();
				avrgRad = PathUtils.calAverDirec2(pathLine);
				view.direction = ISODirection.radianToDirect(avrgRad);
				run();
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
			if(pathLine)
			{
				var curX:Number = view.x;
				var curY:Number = view.y;
				
				var nxtX:Number,nxtY:Number;
				var remainSpeed:Number;
				// 如果速度大小超过了当前线段长度，则提取下一个线段，并将该线段的起始点减去之前剩下的速度量
				if(speed>line.length)
				{
					remainSpeed = speed - line.length;
					line = pathLine.shift();
					line.subLen(remainSpeed);
					if(pathLine.length>10)
					{
						avrgRad = PathUtils.calAverDirec2(pathLine);
						view.direction = ISODirection.radianToDirect(avrgRad);
					}
					else if(pathLine.length == 0)
					{
						attack();
						pathLine = null;
					}
				}
				else
				{
					line.subLen(speed);// 如果速度没有超过当前线段长度 则用当前线段长度减去速度值，
				}
				view.x = line.sx;
				view.y = line.sy;
			}
			view.update();
		}
		
		public function get userId():uint { return uid; }
	}
}