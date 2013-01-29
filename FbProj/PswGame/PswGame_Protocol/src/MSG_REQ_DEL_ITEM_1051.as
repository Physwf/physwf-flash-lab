package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_DEL_ITEM_1051 extends MsgBase
	{
		public var grid:uint;
		public var itemid:uint;
		public var itemcnt:uint;
		
		public function MSG_REQ_DEL_ITEM_1051()
		{
			super(1051)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(grid);
			output.writeUnsignedInt(itemid);
			output.writeUnsignedInt(itemcnt);			
		}
	}
}