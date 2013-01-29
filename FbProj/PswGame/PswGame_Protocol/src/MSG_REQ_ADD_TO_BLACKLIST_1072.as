package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_ADD_TO_BLACKLIST_1072 extends MsgBase
	{
		public var user:uid_role_t;
		
		public function MSG_REQ_ADD_TO_BLACKLIST_1072()
		{
			super(1072)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			user.writeExternal(output)			
		}
	}
}