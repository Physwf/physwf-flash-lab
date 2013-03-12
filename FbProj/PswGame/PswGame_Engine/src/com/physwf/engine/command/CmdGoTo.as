package com.physwf.engine.command
{
	import com.physwf.components.charactor.enum.ISODirection;
	import com.physwf.components.command.Command;
	import com.physwf.components.map.wayfinding.astar.BiHeapAStar;
	import com.physwf.components.map.wayfinding.astar.Line;
	import com.physwf.components.map.wayfinding.astar.PathUtils;
	import com.physwf.engine.world.events.CharacterEvent;
	import com.physwf.engine.world.manager.Character;
	import com.physwf.system.System;
	
	import flash.events.Event;

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
			endX = ex;
			endY = ey;
			var sx:uint = Math.floor(mChara.view.x / 10);
			var sy:uint = Math.floor(mChara.view.y / 10);
			var ex:uint = Math.floor(tx / 10);
			var ey:uint = Math.floor(ty / 10);
			
			if(Character.astar.tryFindPath(sx,sy,ex,ey))
			{
				pathLine = Character.astar.getPathLine();
				
				avrgRad = PathUtils.calAverDirec2(pathLine);
				line = pathLine.shift();
				
				mChara.view.direction = ISODirection.radianToDirect8(avrgRad);
			}
		}
		
		override public function execute():void
		{
			mChara.addEventListener(CharacterEvent.CHARA_PATH_FINISH,onPathFinish);
//			System.myself.move(endX,endY,0);
			mChara.goto(endX,endY);
		}
		
		override public function update():void
		{
			if(pathLine)
			{
				mChara.isMoving = true;
				var remainSpeed:Number;
				// 如果速度大小超过了当前线段长度，则提取下一个线段，并将该线段的起始点减去之前剩下的速度量
				if(mChara.speed>line.length)
				{
					remainSpeed = mChara.speed - line.length;
					
					if(pathLine.length>3)
					{
						avrgRad = PathUtils.calAverDirec2(pathLine);
						mChara.view.direction = ISODirection.radianToDirect8(avrgRad);
					}
					
					if(pathLine.length)
					{
						//						trace("下一个line",pathLine.length)
						line = pathLine.shift();
						line.subLen(remainSpeed);
					}
					else
					{
						line.subLen(line.length);
//						stand();
						mChara.isMoving = false;
						trace(mChara.view.x,mChara.view.x,"角色当前位置")
						dispatchEvent(new Event(Command.FINISH));
					}
					
				}
				else
				{
					//					trace("继续",line.length);
					line.subLen(mChara.speed);// 如果速度没有超过当前线段长度 则用当前线段长度减去速度值，
				}
				mChara.view.x = line.sx;
				mChara.view.y = line.sy;
			}
		}
		
		private function onPathFinish(e:CharacterEvent):void
		{
			mChara.removeEventListener(CharacterEvent.CHARA_PATH_FINISH,onPathFinish);
			dispatchEvent(new Event(Command.FINISH));
		}
	}
}