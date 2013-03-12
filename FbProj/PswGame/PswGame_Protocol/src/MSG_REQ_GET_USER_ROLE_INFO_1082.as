package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_USER_ROLE_INFO_1082 extends MsgBase
	{
		public var user_id:uint;
		
		public function MSG_REQ_GET_USER_ROLE_INFO_1082()
		{
			super(1082)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(user_id);			
		}
	}
}