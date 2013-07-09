package engine.common.command
{
	import flash.events.Event;
	
	import components.character.enums.ISODirection;
	import components.command.Command;
	import components.map.data.GridTypeMapData;
	import components.map.wayfinding.astar.Line;
	import components.map.wayfinding.astar.PathUtils;
	
	import engine.world.objects.Character;
	
	/**
	 * 寻路到指定点 
	 * @author joe
	 * 
	 */
	public class CmdGoTo extends Command
	{
		private var mChara:Character;
		private var endX:uint;
		private var endY:uint;
		private var pathLine:Vector.<Line>;
		private var avrgRad:Number;//路径的方向（取前面若干个点的方向平均）
		private var line:Line;
		
		public function CmdGoTo(chara:Character)
		{
			mChara = chara;
		}
		
		public function setDest(tx:uint,ty:uint):void
		{
			endX = tx;
			endY = ty;
		}
		
		override public function execute():void
		{
			var sx:uint = Math.floor(mChara.view.x / GridTypeMapData.GRID_SIZE);
			var sy:uint = Math.floor(mChara.view.y / GridTypeMapData.GRID_SIZE);
			var ex:uint = Math.floor(endX / GridTypeMapData.GRID_SIZE);
			var ey:uint = Math.floor(endY / GridTypeMapData.GRID_SIZE);

			if(Character.astar.tryFindPath(sx,sy,ex,ey))
			{
				pathLine = Character.astar.getPathLine();
				
				avrgRad = PathUtils.calAverDirec2(pathLine);
				line = pathLine.shift();
				mChara.run();
				mChara.view.direction = ISODirection.radianToDirect8(avrgRad);
			}
			return;
			mChara.asynAstar.addEventListener(Event.COMPLETE,function(e:Event):void
			{
				pathLine = mChara.asynAstar.getPathLine();
				
				avrgRad = PathUtils.calAverDirec2(pathLine);
				line = pathLine.shift();
				mChara.run();
				mChara.view.direction = ISODirection.radianToDirect8(avrgRad);
			});
			
			if(mChara.asynAstar.tryFindPath(sx,sy,ex,ey))
			{
				pathLine = null;
				line = null;
			}
			return;
		}
		
		override public function update(delta:uint):void
		{
			if(pathLine)
			{
				var dist:Number = mChara.speed * delta;
				mChara.isMoving = true;
				var remainSpeed:Number;
				// 如果速度大小超过了当前线段长度，则提取下一个线段，并将该线段的起始点减去之前剩下的速度量
				if(dist>line.length)
				{
					remainSpeed = dist - line.length;
					
					if(pathLine.length>3)
					{
						avrgRad = PathUtils.calAverDirec2(pathLine);
						mChara.view.direction = ISODirection.radianToDirect8(avrgRad);
					}
					
					if(pathLine.length)
					{
						line = pathLine.shift();
						line.subLen(remainSpeed);
					}
					else
					{
						line.subLen(line.length);
						mChara.isMoving = false;
						pathLine = null;
						dispatchEvent(new Event(Command.FINISH));
					}
					
				}
				else
				{
					line.subLen(dist);// 如果速度没有超过当前线段长度 则用当前线段长度减去速度值，
				}
				mChara.view.x = line.sx;
				mChara.view.y = line.sy;
			}
		}
	}
}