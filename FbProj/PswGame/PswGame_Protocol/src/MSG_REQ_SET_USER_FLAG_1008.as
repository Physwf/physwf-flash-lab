package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SET_USER_FLAG_1008 extends MsgBase
	{
		public var flag_bit:uint;
		public var value:uint;
		
		public function MSG_REQ_SET_USER_FLAG_1008()
		{
			super(1008)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeInt(flag_bit);
			output.writeInt(value);			
		}
	}
}