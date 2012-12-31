package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_TASK_FULL_LIST_1024 extends MsgBase
	{
		public var task_full_list:Vector.<task_full_t>;
		
		public function MSG_RES_GET_TASK_FULL_LIST_1024(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var task_full_listLen:uint =input.readUnsignedInt();
			task_full_list= new Vector.<task_full_t>();
			for(var i:int=0;i<task_full_listLen;++i)
			{
				var item:task_full_t = new task_full_t()
				item.readExternal(input);;
				task_full_list.push(item);
			}			
		}
	}
}