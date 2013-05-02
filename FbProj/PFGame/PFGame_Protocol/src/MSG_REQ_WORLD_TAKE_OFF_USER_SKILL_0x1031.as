package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_TAKE_OFF_USER_SKILL_0x1031 extends MsgBase
	{
		public var skill:uint;
		
		public function MSG_REQ_WORLD_TAKE_OFF_USER_SKILL_0x1031()
		{
			super(0x1031)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(skill);			
		}
	}
}