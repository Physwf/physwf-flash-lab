package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_CATCH_PET_1068 extends MsgBase
	{
		public var instance_id:uint;
		
		public function MSG_REQ_CATCH_PET_1068()
		{
			super(1068)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(instance_id);			
		}
	}
}