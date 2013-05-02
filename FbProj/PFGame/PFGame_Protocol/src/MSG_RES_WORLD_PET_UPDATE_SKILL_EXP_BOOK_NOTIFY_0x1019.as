package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_PET_UPDATE_SKILL_EXP_BOOK_NOTIFY_0x1019 extends MsgBase
	{
		public var id:uint;
		public var exp:uint;
		
		public function MSG_RES_WORLD_PET_UPDATE_SKILL_EXP_BOOK_NOTIFY_0x1019(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			exp = input.readUnsignedInt();			
		}
	}
}