package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SET_PET_FOLLOW_1063 extends MsgBase
	{
		public var instance_id:uint;
		
		public function MSG_REQ_SET_PET_FOLLOW_1063()
		{
			super(1063)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(instance_id);			
		}
	}
}