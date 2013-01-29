package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_USER_INFO_1082 extends MsgBase
	{
		public var user:uid_role_t;
		
		public function MSG_REQ_GET_USER_INFO_1082()
		{
			super(1082)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			user.writeExternal(output)			
		}
	}
}