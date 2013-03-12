package com.physwf.components.command
{
	import com.physwf.components.ds.heap.MaxHeap;
	import com.physwf.components.interfaces.INumerical;
	
	import flash.events.Event;

	/**
	 * 最大堆命令序列，顾名思义，命令队列将按命令的优先级来排序，优先级越高将排位越靠前 
	 * @author joe
	 */	
	public class MaxHeapCmdSequence extends CommandSequence
	{
		private var mCmds:MaxHeap;//命令队列中的命令可以是单纯的命令，也可以是命令序列
		private var mCurCmd:ICommand;
		
		public function MaxHeapCmdSequence()
		{
			mCmds = new MaxHeap(10);//暂定
		}
		
		override public function addCommand(cmd:ICommand):ICommand
		{
			mCmds.Enqueue(cmd);
			return cmd;
		}
		
		override public function next():ICommand
		{
			mCurCmd = mCmds.Dequeue() as ICommand;
			if(mCurCmd)
			{
				mCurCmd.addEventListener(Command.FINISH,onCurCmdFinish); 
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
	}
}