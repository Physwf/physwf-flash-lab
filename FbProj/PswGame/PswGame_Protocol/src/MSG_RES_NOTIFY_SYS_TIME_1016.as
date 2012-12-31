package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTIFY_SYS_TIME_1016 extends MsgBase
	{
		public var time:uint;
		
		public function MSG_RES_NOTIFY_SYS_TIME_1016(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			time = input.readUnsignedInt();			
		}
	}
}