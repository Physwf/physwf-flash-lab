package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_OBTAIN_TASK_1020 extends MsgBase
	{
		public var tskid:uint;
		
		public function MSG_RES_OBTAIN_TASK_1020(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			tskid = input.readUnsignedInt();			
		}
	}
}