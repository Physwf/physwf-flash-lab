package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SET_USER_FLAG_1075 extends MsgBase
	{
		public var flag_bit:uint;
		public var value:uint;
		
		public function MSG_REQ_SET_USER_FLAG_1075()
		{
			super(1075)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(flag_bit);
			output.writeUnsignedInt(value);			
		}
	}
}