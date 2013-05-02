package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_MOVE_0x1004 extends MsgBase
	{
		public var pos:world_user_pos_t;
		
		public function MSG_REQ_WORLD_USER_MOVE_0x1004()
		{
			super(0x1004)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			pos.writeExternal(output)			
		}
	}
}