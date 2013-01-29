package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_USER_LEVEL_UP_1010 extends MsgBase
	{
		public var level:uint;
		
		public function MSG_RES_USER_LEVEL_UP_1010(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			level = input.readUnsignedShort();			
		}
	}
}