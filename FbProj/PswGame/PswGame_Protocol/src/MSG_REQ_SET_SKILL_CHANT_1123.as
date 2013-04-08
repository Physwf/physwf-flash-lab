package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SET_SKILL_CHANT_1123 extends MsgBase
	{
		public var skill_id:uint;
		public var direction:uint;
		
		public function MSG_REQ_SET_SKILL_CHANT_1123()
		{
			super(1123)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(skill_id);
			output.writeByte(direction);			
		}
	}
}