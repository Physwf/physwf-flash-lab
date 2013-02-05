package com.physwf.engine.command
{
	import com.physwf.components.interfaces.INumerical;
	
	import flash.events.EventDispatcher;

	/**
	 * 命令基类。多个命令的执行顺序由该命令的优先级决定。 
	 * @author joe
	 * 
	 */
	public class Command extends EventDispatcher implements INumerical
	{
		public static const FINISH:String = "finish";
		
		protected var mPriority:uint;
		
		public function Command()
		{
		}
		
		public function execute():void
		{
			
		}
		
		public function get value():Number
		{
			return mPriority;
		}
	}
}