package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_ADD_PET_SKILL_CNT_NOTIFY_0x1026 extends MsgBase
	{
		public var skill_id:uint;
		public var add_exp:uint;
		
		public function MSG_RES_WORLD_ADD_PET_SKILL_CNT_NOTIFY_0x1026(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			skill_id = input.readUnsignedInt();
			add_exp = input.readUnsignedInt();			
		}
	}
}