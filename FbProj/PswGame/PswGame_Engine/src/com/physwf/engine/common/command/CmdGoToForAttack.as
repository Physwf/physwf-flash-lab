package com.physwf.engine.common.command
{
	import com.physwf.components.charactor.enum.ISODirection;
	import com.physwf.components.command.Command;
	import com.physwf.components.map.wayfinding.astar.Line;
	import com.physwf.components.map.wayfinding.astar.PathUtils;
	import com.physwf.engine.world.manager.Character;
	import com.physwf.system.vo.SkillInfo;
	
	import flash.events.Event;
	
	public class CmdGoToForAttack extends Command
	{
		private var mChara:Character;
		private var endX:uint;
		private var endY:uint;
		private var mSkill:SkillInfo;
		
		private var pathLine:Vector.<Line>;
		private var avrgRad:Number;//路径的方向（取前面若干个点的方向平均）
		private var line:Line;
		
		public function CmdGoToForAttack(chara:Character)
		{
			mChara = chara;
		}
		
		public function setDest(tx:uint,ty:uint):void
		{
			endX = tx;
			endY = ty;
		}
		
		public function setSkill(skill:SkillInfo):void
		{
			mSkill = skill;
		}
		
		override public function execute():void
		{
			var distX:int = mChara.view.x - endX;
			var distY:int = mChara.view.x - endY;
			if(distX * distX + distY * distY <= mSkill.range * mSkill.range)
			{
				pathLine = null;
				dispatchEvent(new Event(Command.FINISH));
				return;
			}
			
			var sx:uint = Math.floor(mChara.view.x / 10);
			var sy:uint = Math.floor(mChara.view.y / 10);
			var ex:uint = Math.floor(endX / 10);
			var ey:uint = Math.floor(endY / 10);
			
			if(Character.astar.tryFindPath(sx,sy,ex,ey))
			{
				pathLine = Character.astar.getPathLine();
				
				avrgRad = PathUtils.calAverDirec2(pathLine);
				line = pathLine.shift();
				mChara.run();
				mChara.view.direction = ISODirection.radianToDirect8(avrgRad);
			}
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
					line.subLen(mChara.speed);// 如果速度没有超过当前线段长度 则用当前线段长度减去速度值，
				}
				mChara.view.x = line.sx;
				mChara.view.y = line.sy;
				//到达了技能的范围之内
				var distX:int = line.sx - endX;
				var distY:int = line.sy - endY;
				if(distX * distX + distY * distY <= mSkill.range * mSkill.range)
				{
					pathLine = null;
					dispatchEvent(new Event(Command.FINISH));
				}
			}
		}
	}
}