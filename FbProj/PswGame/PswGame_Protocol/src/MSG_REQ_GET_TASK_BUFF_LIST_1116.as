package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_TASK_BUFF_LIST_1116 extends MsgBase
	{
		public var tskid_list:Vector.<uint>;
		
		public function MSG_REQ_GET_TASK_BUFF_LIST_1116()
		{
			super(1116)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(tskid_list.length);
			for(var i:int=0;i<tskid_list.length;++i)
			{
				output.writeUnsignedInt(tskid_list[i]);
			}			
		}
	}
}