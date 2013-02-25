package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_ATTR_CHANGE_1011 extends MsgBase
	{
		public var uid:uint;
		public var attr:warrior_attr_t;
		
		public function MSG_RES_NOTI_ATTR_CHANGE_1011(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			uid = input.readUnsignedInt();
			attr= new warrior_attr_t();
			attr.readExternal(input)			
		}
	}
}