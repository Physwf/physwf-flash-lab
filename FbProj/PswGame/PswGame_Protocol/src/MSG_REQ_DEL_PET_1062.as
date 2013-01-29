package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_DEL_PET_1062 extends MsgBase
	{
		public var instance_id:uint;
		public var pet_id:uint;
		
		public function MSG_REQ_DEL_PET_1062()
		{
			super(1062)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(instance_id);
			output.writeShort(pet_id);			
		}
	}
}