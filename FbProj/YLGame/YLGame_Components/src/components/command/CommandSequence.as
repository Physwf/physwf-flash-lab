package components.command
{
	import flash.events.EventDispatcher;
	/**
	 * 命令序列用来完成角色的一系列动作，如追击+打怪，剧情中的人物表现等等。 
	 * @author joe
	 * 
	 */	
	public class CommandSequence extends EventDispatcher implements ICommand
	{
		public function CommandSequence()
		{
		}
		/**
		 * 由子类来实现命令的添加，子类可以根据不同的策略来对命令序列进行排序。
		 * @param cmd
		 * @return 
		 */		
		public function addCommand(cmd:ICommand):ICommand
		{
			throw "由子类来实现！";
			return null;
		}
		/**
		 * 执行下一条命令 
		 * @return 
		 * 
		 */		
		public function next():ICommand
		{
			throw "由子类来实现！";
			return null;
		}
		
		public function execute():void
		{
		}
		
		public function update(delta:uint):void
		{
		}
		
		public function get value():Number
		{
			return 0;
		}
	}
}