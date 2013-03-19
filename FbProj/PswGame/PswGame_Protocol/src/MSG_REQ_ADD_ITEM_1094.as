package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_ADD_ITEM_1094 extends MsgBase
	{
		public var item_id:uint;
		public var item_cnt:uint;
		
		public function MSG_REQ_ADD_ITEM_1094()
		{
			super(1094)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(item_id);
			output.writeUnsignedInt(item_cnt);			
		}
	}
}