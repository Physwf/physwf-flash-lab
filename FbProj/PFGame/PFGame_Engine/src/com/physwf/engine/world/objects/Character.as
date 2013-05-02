package com.physwf.engine.world.objects
{
	import com.physwf.components.charactor.CharacterAnimation;
	import com.physwf.components.charactor.enum.CharacterAction;
	import com.physwf.components.command.ICommand;
	import com.physwf.components.command.LinerCmdSequence;
	import com.physwf.components.effects.HeadEffect;
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.wayfinding.astar.IAstar;
	import com.physwf.components.map.wayfinding.astar.Line;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class Character extends EventDispatcher implements IUpdatable,IDisposible
	{
		public var view:CharacterAnimation;
		public static var managers:Dictionary;//从显示到manager的映射,用于在战斗系统中通过鼠标事件目标获取角色对象
		
		protected var mHeadEffect:HeadEffect;
		public function get headEffect():HeadEffect { return mHeadEffect; }
		
		public static var astar:IAstar;
		private var pathLine:Vector.<Line>;
		
		private var target_x:uint;
		private var target_y:uint;
		private var _speed:uint = 6;
		public function get speed():uint { return _speed; }
		private var rad:Number;// 速度的方向
		private var avrgRad:Number;//路径的方向（取前面若干个点的方向平均）
		private var line:Line;
		
		public var isMoving:Boolean = false;
		
		protected var mCmd:ICommand;//主线程
		protected var mCmdThreads:Vector.<ICommand>;//辅助线程
		
		public function get id():uint { return 0};//需要在子类中重写
		
		public function Character()
		{
			mCmdThreads = new Vector.<ICommand>();
		}
		/**
		 * 创建辅助线程 
		 * @param thread
		 * @return 
		 * 
		 */		
		public function createThread(thread:ICommand=null):ICommand
		{
			thread ||= new LinerCmdSequence();
			mCmdThreads.push(thread);
			return thread;
		}
		/**
		 * 主线程推送命令 
		 * @param cmd
		 * 
		 */		
		public function execute(cmd:ICommand):void
		{
			mCmd = cmd;
			mCmd.execute();
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
			view.action = CharacterAction.ACTION_ATTACK;
		}
		
		public function die():void
		{
			trace("dead!");
		}
		
		public function show():void
		{
			view.visible = true;
		}
		
		public function hide():void
		{
			view.visible = false;
		}
		
		public function update():void
		{
			mCmd.update();
			for(var i:uint=0;i<mCmdThreads.length;++i)
			{
				mCmdThreads[i].update();
			}
			view.update();
		}
		
		public function destroy():void
		{
			mHeadEffect = null;
		}
		
	}
}