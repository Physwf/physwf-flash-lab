package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_USER_LEVEL_UP_1010 extends MsgBase
	{
		public var user_id:uint;
		public var role_tm:uint;
		public var level:uint;
		
		public function MSG_RES_USER_LEVEL_UP_1010(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_id = input.readUnsignedInt();
			role_tm = input.readUnsignedInt();
			level = input.readUnsignedShort();			
		}
	}
}