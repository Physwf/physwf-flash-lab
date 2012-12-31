package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_FINISH_TASK_1022 extends MsgBase
	{
		public var tskid:uint;
		public var optional_pos:uint;
		
		public function MSG_RES_FINISH_TASK_1022(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			tskid = input.readUnsignedInt();
			optional_pos = input.readUnsignedInt();			
		}
	}
}