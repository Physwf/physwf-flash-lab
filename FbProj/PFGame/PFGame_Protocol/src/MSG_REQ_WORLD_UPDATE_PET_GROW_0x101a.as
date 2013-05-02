package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_UPDATE_PET_GROW_0x101a extends MsgBase
	{
		public var pos:uint;
		public var pet_key:uint;
		
		public function MSG_REQ_WORLD_UPDATE_PET_GROW_0x101a()
		{
			super(0x101a)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(pos);
			output.writeUnsignedInt(pet_key);			
		}
	}
}