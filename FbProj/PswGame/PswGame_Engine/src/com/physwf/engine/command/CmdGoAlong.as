package com.physwf.engine.command
{
	import com.physwf.components.charactor.enum.ISODirection;
	import com.physwf.components.command.Command;
	import com.physwf.components.map.wayfinding.astar.Line;
	import com.physwf.components.map.wayfinding.astar.Node;
	import com.physwf.components.map.wayfinding.astar.PathUtils;
	import com.physwf.engine.world.manager.Character;
	
	import flash.events.Event;
	
	public class CmdGoAlong extends Command
	{
		private var rawPath:Vector.<uint>;
		private var pathLine:Vector.<Line>;
		private var rad:Number;// 速度的方向
		private var avrgRad:Number;//路径的方向（取前面若干个点的方向平均）
		private var line:Line;
		
		private var mChara:Character;
		
		public function CmdGoAlong(chara:Character)
		{
			mChara = chara;
		}
		
		public function setPath(rawPath:Vector.<uint>):void
		{
			this.rawPath = rawPath;
			trace(rawPath,"rawPath");
			trace(mChara.view.x);
			trace(mChara.view.y);
		}
		
		override public function execute():void
		{
			var len:uint = rawPath.length-2;
			var path:Vector.<Line> = new Vector.<Line>();
			for(var i:uint=0;i<len;i+=2)
			{
				var prev:Node = new Node(rawPath[i],rawPath[i+1]);
				var next:Node = new Node(rawPath[i+2],rawPath[i+3]);
				var ln:Line = new Line(prev,next);
				path.push(ln);
			}
			pathLine = path;
			if(pathLine.length>0)
			{
				avrgRad = PathUtils.calAverDirec2(pathLine);
				line = pathLine.shift();
				mChara.view.direction = ISODirection.radianToDirect8(avrgRad);
				mChara.run();
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
						trace(mChara.view.x,mChara.view.x,"角色当前位置")
						pathLine = null;
						dispatchEvent(new Event(Command.FINISH));
					}
					
				}
				else
				{
					trace(line.length,"line.length")
					line.subLen(mChara.speed);// 如果速度没有超过当前线段长度 则用当前线段长度减去速度值，
					trace(line.sx,line.sy,"goalong");
				}
				mChara.view.x = line.sx;
				mChara.view.y = line.sy;
			}
		}
	}
}