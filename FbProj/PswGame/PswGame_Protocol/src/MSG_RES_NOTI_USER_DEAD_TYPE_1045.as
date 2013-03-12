package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_USER_DEAD_TYPE_1045 extends MsgBase
	{
		public var type:uint;
		public var src_id:uint;
		public var src_type:uint;
		public var money_lose:uint;
		public var exp_lose:uint;
		public var duration_type:uint;
		
		public function MSG_RES_NOTI_USER_DEAD_TYPE_1045(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			type = input.readUnsignedByte();
			src_id = input.readUnsignedInt();
			src_type = input.readUnsignedByte();
			money_lose = input.readUnsignedInt();
			exp_lose = input.readUnsignedInt();
			duration_type = input.readUnsignedInt();			
		}
	}
}