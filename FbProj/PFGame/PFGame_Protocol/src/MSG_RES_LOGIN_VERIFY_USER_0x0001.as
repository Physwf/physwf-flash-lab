package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_LOGIN_VERIFY_USER_0x0001 extends MsgBase
	{
		public var user_name:String;
		public var user_name_data:ByteArray
		public var user_id:uint;
		public var reg_time:uint;
		public var vip_level:uint;
		public var vip_time_out:uint;
		public var wallow:uint;
		public var from_site:String;
		public var from_site_data:ByteArray
		
		public function MSG_RES_LOGIN_VERIFY_USER_0x0001(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_name = input.readUTF();
			user_id = input.readUnsignedInt();
			reg_time = input.readUnsignedInt();
			vip_level = input.readUnsignedInt();
			vip_time_out = input.readUnsignedInt();
			wallow = input.readUnsignedShort();
			from_site = input.readUTF();			
		}
	}
}