package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_DEL_ITEM_1051 extends MsgBase
	{
		public var grid:uint;
		public var itemid:uint;
		public var itemcnt:uint;
		
		public function MSG_RES_DEL_ITEM_1051(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			grid = input.readUnsignedShort();
			itemid = input.readUnsignedInt();
			itemcnt = input.readUnsignedInt();			
		}
	}
}