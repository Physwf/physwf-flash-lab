package engine.world.objects
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import components.bitmap.net.SkeletonLoader;
	import components.character.CharacterAnimation;
	import components.character.enum.CharacterAction;
	import components.character.enum.ISODirection;
	import components.command.ICommand;
	import components.command.LinerCmdSequence;
	import components.interfaces.IDisposible;
	import components.interfaces.IUpdatable;
	import components.map.wayfinding.astar.IAstar;
	import components.map.wayfinding.astar.Line;
	
	import engine.common.command.CmdStand;
	
	public class Character extends EventDispatcher implements IUpdatable,IDisposible
	{
		public var view:CharacterAnimation;
		public static var managers:Dictionary;//从显示到manager的映射,用于在战斗系统中通过鼠标事件目标获取角色对象
		
		public static var astar:IAstar;
		private var pathLine:Vector.<Line>;
		
		private var target_x:uint;
		private var target_y:uint;
		private var _speed:Number = 1/6;
		public function get speed():Number { return _speed; }
		private var rad:Number;// 速度的方向
		private var avrgRad:Number;//路径的方向（取前面若干个点的方向平均）
		private var line:Line;
		
		public var isMoving:Boolean = false;
		
		protected var mCmd:ICommand;//主线程
		protected var mCmdThreads:Vector.<ICommand>;//辅助线程
		
		public function get id():uint { return 0};//需要在子类中重写
		
		
		public static var self:Character;
		
		public function Character()
		{
			mCmdThreads = new Vector.<ICommand>();
			view = new CharacterAnimation();
			var nude:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/armor/10_00001");
			view.body.changeWear(0,nude);
			view.direction = ISODirection.DOWN;
			execute(new CmdStand(this));
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
			view.status = CharacterAction.ACTION_IDLE;
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
			view.action = CharacterAction.ACTION_ATTACK0;
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
		
		public function update(delta:uint):void
		{
			mCmd.update(delta);
			for(var i:uint=0;i<mCmdThreads.length;++i)
			{
				mCmdThreads[i].update(delta);
			}
			view.update(delta);
		}
		
		public function destroy():void
		{
		}
		
	}
}