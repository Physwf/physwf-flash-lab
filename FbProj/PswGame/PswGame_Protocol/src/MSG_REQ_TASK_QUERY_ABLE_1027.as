package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_TASK_QUERY_ABLE_1027 extends MsgBase
	{
		public var query_type:uint;
		public var tskid_list:Vector.<uint>;
		
		public function MSG_REQ_TASK_QUERY_ABLE_1027()
		{
			super(1027)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(query_type);
			output.writeUnsignedInt(tskid_list.length);
			for(var i:int=0;i<tskid_list.length;++i)
			{
				output.writeUnsignedInt(tskid_list[i]);
			}			
		}
	}
}