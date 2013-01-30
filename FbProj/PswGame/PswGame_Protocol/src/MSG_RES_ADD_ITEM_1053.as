package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_ADD_ITEM_1053 extends MsgBase
	{
		public var item:stru_item_t;
		
		public function MSG_RES_ADD_ITEM_1053(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			item= new stru_item_t();
			item.readExternal(input)			
		}
	}
}