package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_TASK_FLAG_LIST_1023 extends MsgBase
	{
		public var task_flag_list:Vector.<task_flag_t>;
		
		public function MSG_RES_GET_TASK_FLAG_LIST_1023(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var task_flag_listLen:uint =input.readUnsignedInt();
			task_flag_list= new Vector.<task_flag_t>();
			for(var i:int=0;i<task_flag_listLen;++i)
			{
				var item:task_flag_t = new task_flag_t()
				item.readExternal(input);;
				task_flag_list.push(item);
			}			
		}
	}
}