package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_BUY_ITEM_0x1009 extends MsgBase
	{
		public var idx:uint;
		public var cnt:uint;
		
		public function MSG_REQ_WORLD_USER_BUY_ITEM_0x1009()
		{
			super(0x1009)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(idx);
			output.writeUnsignedInt(cnt);			
		}
	}
}