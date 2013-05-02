package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_ADD_7_ATTR_0x1032 extends MsgBase
	{
		public var attr_id:uint;
		
		public function MSG_REQ_WORLD_USER_ADD_7_ATTR_0x1032()
		{
			super(0x1032)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(attr_id);			
		}
	}
}