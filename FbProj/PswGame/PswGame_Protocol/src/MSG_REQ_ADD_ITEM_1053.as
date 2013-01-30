package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_ADD_ITEM_1053 extends MsgBase
	{
		public var item:stru_item_t;
		
		public function MSG_REQ_ADD_ITEM_1053()
		{
			super(1053)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			item.writeExternal(output)			
		}
	}
}