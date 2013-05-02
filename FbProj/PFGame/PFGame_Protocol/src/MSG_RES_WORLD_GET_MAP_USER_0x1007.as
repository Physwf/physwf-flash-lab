package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_GET_MAP_USER_0x1007 extends MsgBase
	{
		public var users_info:Vector.<world_user_map_show_info_t>;
		
		public function MSG_RES_WORLD_GET_MAP_USER_0x1007(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var users_infoLen:uint =input.readUnsignedInt();
			users_info= new Vector.<world_user_map_show_info_t>();
			for(var i:uint=0;i<users_infoLen;i++)
			{
				var users_info_item:world_user_map_show_info_t = new world_user_map_show_info_t()
				users_info_item.readExternal(input);;
				users_info.push(users_info_item);
			}			
		}
	}
}