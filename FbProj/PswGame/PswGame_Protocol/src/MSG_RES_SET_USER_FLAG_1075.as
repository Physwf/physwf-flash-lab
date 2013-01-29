package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_SET_USER_FLAG_1075 extends MsgBase
	{
		public var flag:uint;
		
		public function MSG_RES_SET_USER_FLAG_1075(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			flag = input.readUnsignedInt();			
		}
	}
}