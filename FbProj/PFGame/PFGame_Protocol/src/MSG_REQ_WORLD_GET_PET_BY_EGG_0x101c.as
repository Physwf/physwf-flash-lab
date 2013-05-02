package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_GET_PET_BY_EGG_0x101c extends MsgBase
	{
		public var egg_pos:uint;
		
		public function MSG_REQ_WORLD_GET_PET_BY_EGG_0x101c()
		{
			super(0x101c)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeByte(egg_pos);			
		}
	}
}