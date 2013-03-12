package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_USE_ITEM_REBIRTH_1057 extends MsgBase
	{
		public var grid:uint;
		public var item_id:uint;
		public var item_cnt:uint;
		
		public function MSG_REQ_USE_ITEM_REBIRTH_1057()
		{
			super(1057)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(grid);
			output.writeUnsignedInt(item_id);
			output.writeUnsignedInt(item_cnt);			
		}
	}
}