package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_UPDATE_BASE_ITEM_NOTIFY_0x1010 extends MsgBase
	{
		public var id:uint;
		public var cnt:uint;
		
		public function MSG_RES_WORLD_USER_UPDATE_BASE_ITEM_NOTIFY_0x1010(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			cnt = input.readUnsignedInt();			
		}
	}
}