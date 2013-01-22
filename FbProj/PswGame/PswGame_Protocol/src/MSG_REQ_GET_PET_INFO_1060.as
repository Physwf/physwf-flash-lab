package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_PET_INFO_1060 extends MsgBase
	{
		public var instance_id:uint;
		public var petid:uint;
		
		public function MSG_REQ_GET_PET_INFO_1060()
		{
			super(1060)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(instance_id);
			output.writeUnsignedInt(petid);			
		}
	}
}