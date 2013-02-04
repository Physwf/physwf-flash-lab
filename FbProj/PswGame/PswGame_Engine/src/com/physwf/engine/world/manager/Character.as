package com.physwf.engine.world.manager
{
	import com.physwf.components.charactor.CharacterAnimation;
	import com.physwf.components.charactor.enum.CharacterAction;
	import com.physwf.components.charactor.enum.ISODirection;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.wayfinding.astar.IAstar;
	import com.physwf.components.map.wayfinding.astar.Line;
	import com.physwf.components.map.wayfinding.astar.PathUtils;
	import com.physwf.engine.world.events.CharacterEvent;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class Character extends EventDispatcher implements IUpdatable
	{
		public static var self:Character;
		
		public var view:CharacterAnimation;
		public static var managers:Dictionary;//从显示到manager的映射,用于在战斗系统中通过鼠标事件目标获取角色对象
		
		public static var astar:IAstar;
		private var pathLine:Vector.<Line>;
		
		private var target_x:uint;
		private var target_y:uint;
		private var speed:uint = 6;
		private var rad:Number;// 速度的方向
		private var avrgRad:Number;//路径的方向（取前面若干个点的方向平均）
		private var line:Line;
		
		public function Character()
		{
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
			pathLine = null;
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
			pathLine = null;
			view.action = CharacterAction.ACTION_ATTACK;
		}
		
		public function die():void
		{
			trace("dead!");
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
						stand();
						pathLine = null;
						dispatchEvent(new CharacterEvent(CharacterEvent.CHARA_PATH_FINISH));
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
		
	}
}