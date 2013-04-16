package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_ANY_USER_INFO_1126 extends MsgBase
	{
		public var user_id:uint;
		public var role_tm:uint;
		
		public function MSG_REQ_GET_ANY_USER_INFO_1126()
		{
			super(1126)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(user_id);
			output.writeUnsignedInt(role_tm);			
		}
	}
}