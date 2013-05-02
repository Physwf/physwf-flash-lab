package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_USE_POS_ITEM_0x1008 extends MsgBase
	{
		public var pos:uint;
		
		public function MSG_REQ_WORLD_USER_USE_POS_ITEM_0x1008()
		{
			super(0x1008)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(pos);			
		}
	}
}