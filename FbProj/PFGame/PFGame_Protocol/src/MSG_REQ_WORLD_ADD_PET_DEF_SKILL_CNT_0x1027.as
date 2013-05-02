package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_ADD_PET_DEF_SKILL_CNT_0x1027 extends MsgBase
	{
		public var book_pos:uint;
		public var pet_key:uint;
		
		public function MSG_REQ_WORLD_ADD_PET_DEF_SKILL_CNT_0x1027()
		{
			super(0x1027)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(book_pos);
			output.writeUnsignedInt(pet_key);			
		}
	}
}