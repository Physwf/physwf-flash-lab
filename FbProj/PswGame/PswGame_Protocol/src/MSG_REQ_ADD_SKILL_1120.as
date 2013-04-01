package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_ADD_SKILL_1120 extends MsgBase
	{
		public var skill_id:uint;
		
		public function MSG_REQ_ADD_SKILL_1120()
		{
			super(1120)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(skill_id);			
		}
	}
}