package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_BUFF_INFO_1047 extends MsgBase
	{
		public var src_id:uint;
		public var src_type:uint;
		public var buff_id:uint;
		public var buff_opt:uint;
		public var value:uint;
		
		public function MSG_RES_NOTI_BUFF_INFO_1047(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			src_id = input.readUnsignedInt();
			src_type = input.readUnsignedByte();
			buff_id = input.readUnsignedShort();
			buff_opt = input.readUnsignedByte();
			value = input.readUnsignedInt();			
		}
	}
}