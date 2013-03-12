package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_SYS_TIME_1003 extends MsgBase
	{
		public var timestamp:uint;
		
		public function MSG_RES_GET_SYS_TIME_1003(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			timestamp = input.readUnsignedInt();			
		}
	}
}