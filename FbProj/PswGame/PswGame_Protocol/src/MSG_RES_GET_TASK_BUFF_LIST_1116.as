package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_TASK_BUFF_LIST_1116 extends MsgBase
	{
		public var task_buff_list:Vector.<task_idbuff_t>;
		
		public function MSG_RES_GET_TASK_BUFF_LIST_1116(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var task_buff_listLen:uint =input.readUnsignedInt();
			task_buff_list= new Vector.<task_idbuff_t>();
			for(var i:int=0;i<task_buff_listLen;++i)
			{
				var task_buff_list_item:task_idbuff_t = new task_idbuff_t()
				task_buff_list_item.readExternal(input);;
				task_buff_list.push(task_buff_list_item);
			}			
		}
	}
}