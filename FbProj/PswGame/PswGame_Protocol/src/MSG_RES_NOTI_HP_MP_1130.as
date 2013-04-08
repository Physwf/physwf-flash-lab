package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_HP_MP_1130 extends MsgBase
	{
		public var src_id:uint;
		public var src_type:uint;
		public var hp:uint;
		public var mp:uint;
		
		public function MSG_RES_NOTI_HP_MP_1130(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			src_id = input.readUnsignedInt();
			src_type = input.readUnsignedByte();
			hp = input.readUnsignedInt();
			mp = input.readUnsignedInt();			
		}
	}
}