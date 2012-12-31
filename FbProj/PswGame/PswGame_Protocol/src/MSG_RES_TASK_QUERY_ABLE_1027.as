package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_TASK_QUERY_ABLE_1027 extends MsgBase
	{
		public var task_able_list:Vector.<task_able_t>;
		
		public function MSG_RES_TASK_QUERY_ABLE_1027(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var task_able_listLen:uint =input.readUnsignedInt();
			task_able_list= new Vector.<task_able_t>();
			for(var i:int=0;i<task_able_listLen;++i)
			{
				var item:task_able_t = new task_able_t()
				item.readExternal(input);;
				task_able_list.push(item);
			}			
		}
	}
}