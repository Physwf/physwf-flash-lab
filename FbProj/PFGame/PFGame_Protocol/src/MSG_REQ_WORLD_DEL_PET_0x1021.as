package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_DEL_PET_0x1021 extends MsgBase
	{
		public var key:uint;
		
		public function MSG_REQ_WORLD_DEL_PET_0x1021()
		{
			super(0x1021)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(key);			
		}
	}
}