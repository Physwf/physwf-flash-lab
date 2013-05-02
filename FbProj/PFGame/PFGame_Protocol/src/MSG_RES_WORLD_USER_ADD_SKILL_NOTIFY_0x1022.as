package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_ADD_SKILL_NOTIFY_0x1022 extends MsgBase
	{
		public var skill_id:uint;
		
		public function MSG_RES_WORLD_USER_ADD_SKILL_NOTIFY_0x1022(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			skill_id = input.readUnsignedInt();			
		}
	}
}