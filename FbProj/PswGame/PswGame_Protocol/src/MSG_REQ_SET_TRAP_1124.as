package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SET_TRAP_1124 extends MsgBase
	{
		public var skill_id:uint;
		public var map_x:uint;
		public var map_y:uint;
		
		public function MSG_REQ_SET_TRAP_1124()
		{
			super(1124)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(skill_id);
			output.writeShort(map_x);
			output.writeShort(map_y);			
		}
	}
}