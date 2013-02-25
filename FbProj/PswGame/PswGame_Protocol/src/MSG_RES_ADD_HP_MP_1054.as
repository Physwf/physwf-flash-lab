package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_ADD_HP_MP_1054 extends MsgBase
	{
		public var grid:uint;
		public var item_id:uint;
		public var item_cnt:uint;
		
		public function MSG_RES_ADD_HP_MP_1054(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			grid = input.readUnsignedShort();
			item_id = input.readUnsignedInt();
			item_cnt = input.readUnsignedInt();			
		}
	}
}