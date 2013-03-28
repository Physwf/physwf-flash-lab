package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_UPGRADE_SKILL_1121 extends MsgBase
	{
		public var skill_id:uint;
		public var skill_lv:uint;
		
		public function MSG_REQ_UPGRADE_SKILL_1121()
		{
			super(1121)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(skill_id);
			output.writeShort(skill_lv);			
		}
	}
}