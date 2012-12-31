package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_MAP_USER_DETAIL_INFO_1033 extends MsgBase
	{
		public var user:uid_role_t;
		public var nick:String;
		public var level:uint;
		public var exp:uint;
		public var base_attr:player_base_attr_t;
		
		public function MSG_RES_GET_MAP_USER_DETAIL_INFO_1033(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user= new uid_role_t();
			user.readExternal(input)
			nick = input.readUTFBytes(32);
			level = input.readUnsignedInt();
			exp = input.readUnsignedInt();
			base_attr= new player_base_attr_t();
			base_attr.readExternal(input)			
		}
	}
}