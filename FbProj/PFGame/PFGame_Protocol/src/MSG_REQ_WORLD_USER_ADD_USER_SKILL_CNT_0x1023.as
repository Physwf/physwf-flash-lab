package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_ADD_USER_SKILL_CNT_0x1023 extends MsgBase
	{
		public var book_pos:uint;
		public var skill_id:uint;
		
		public function MSG_REQ_WORLD_USER_ADD_USER_SKILL_CNT_0x1023()
		{
			super(0x1023)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(book_pos);
			output.writeUnsignedInt(skill_id);			
		}
	}
}