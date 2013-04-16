package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_BODY_EQUIP_1127 extends MsgBase
	{
		public var user_id:uint;
		public var role_tm:uint;
		
		public function MSG_REQ_GET_BODY_EQUIP_1127()
		{
			super(1127)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(user_id);
			output.writeUnsignedInt(role_tm);			
		}
	}
}