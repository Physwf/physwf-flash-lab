package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_EGG_USE_ITEM_0x101b extends MsgBase
	{
		public var item_id:uint;
		public var egg_pos:uint;
		
		public function MSG_REQ_WORLD_EGG_USE_ITEM_0x101b()
		{
			super(0x101b)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(item_id);
			output.writeByte(egg_pos);			
		}
	}
}