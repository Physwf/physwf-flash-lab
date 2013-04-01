package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_ATTR_CHANGE_1011 extends MsgBase
	{
		public var src_id:uint;
		public var src_type:uint;
		public var attr:warrior_attr_t;
		
		public function MSG_RES_NOTI_ATTR_CHANGE_1011(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			src_id = input.readUnsignedInt();
			src_type = input.readUnsignedByte();
			attr= new warrior_attr_t();
			attr.readExternal(input)			
		}
	}
}