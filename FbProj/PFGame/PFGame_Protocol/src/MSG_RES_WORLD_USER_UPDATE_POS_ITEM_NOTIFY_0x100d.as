package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_UPDATE_POS_ITEM_NOTIFY_0x100d extends MsgBase
	{
		public var data:db_item_t;
		
		public function MSG_RES_WORLD_USER_UPDATE_POS_ITEM_NOTIFY_0x100d(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			data= new db_item_t();
			data.readExternal(input)			
		}
	}
}