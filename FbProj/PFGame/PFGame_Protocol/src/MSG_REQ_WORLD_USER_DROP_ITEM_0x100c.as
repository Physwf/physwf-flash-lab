package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_DROP_ITEM_0x100c extends MsgBase
	{
		public var pos:uint;
		
		public function MSG_REQ_WORLD_USER_DROP_ITEM_0x100c()
		{
			super(0x100c)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(pos);			
		}
	}
}