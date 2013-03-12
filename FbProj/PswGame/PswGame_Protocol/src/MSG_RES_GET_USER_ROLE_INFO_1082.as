package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_USER_ROLE_INFO_1082 extends MsgBase
	{
		public var user_id:uint;
		public var roles:Vector.<role_info_t>;
		
		public function MSG_RES_GET_USER_ROLE_INFO_1082(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_id = input.readUnsignedInt();
			var rolesLen:uint =input.readUnsignedInt();
			roles= new Vector.<role_info_t>();
			for(var i:int=0;i<rolesLen;++i)
			{
				var roles_item:role_info_t = new role_info_t()
				roles_item.readExternal(input);;
				roles.push(roles_item);
			}			
		}
	}
}