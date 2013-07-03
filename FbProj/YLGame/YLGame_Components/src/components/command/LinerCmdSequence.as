package components.command
{
	import flash.events.Event;
	
	/**
	 * 线性命令为一个命令序列，该命令中包含的子命令将按照添加的顺序来执行 
	 * @author joe
	 * 
	 */	
	public class LinerCmdSequence extends CommandSequence
	{
		private var mCmds:Vector.<ICommand>;//命令队列中的命令可以是单纯的命令，也可以是命令序列
		private var mCurCmd:ICommand;
		
		public function LinerCmdSequence()
		{
			mCmds = new Vector.<ICommand>;
		}
		
		override public function addCommand(cmd:ICommand):ICommand
		{
			mCmds.push(cmd);
			return cmd;
		}
		
		override public function next():ICommand
		{
			mCurCmd = mCmds.shift();
			if(mCurCmd != null)
			{
				mCurCmd.addEventListener(Command.FINISH,onCurCmdFinish); 
				mCurCmd.execute();
			}
			else
			{
				dispatchEvent(new Event(Command.FINISH));
			}
			return mCurCmd;
		}
		
		private function onCurCmdFinish(e:Event):void
		{
			mCurCmd.removeEventListener(Command.FINISH,onCurCmdFinish); 
			next();
		}
		
		override public function execute():void
		{
			next();
		}
		
		override public function update(delta:uint):void
		{
			if(mCurCmd) mCurCmd.update(delta);
		}
	}
}