package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_TASK_LIST_1113 extends MsgBase
	{
		public var tasks:Vector.<stru_task_t>;
		
		public function MSG_RES_GET_TASK_LIST_1113(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var tasksLen:uint =input.readUnsignedInt();
			tasks= new Vector.<stru_task_t>();
			for(var i:int=0;i<tasksLen;++i)
			{
				var tasks_item:stru_task_t = new stru_task_t()
				tasks_item.readExternal(input);;
				tasks.push(tasks_item);
			}			
		}
	}
}