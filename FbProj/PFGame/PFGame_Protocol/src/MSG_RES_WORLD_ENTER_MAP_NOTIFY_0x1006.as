package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_ENTER_MAP_NOTIFY_0x1006 extends MsgBase
	{
		public var user_info:world_user_map_show_info_t;
		
		public function MSG_RES_WORLD_ENTER_MAP_NOTIFY_0x1006(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_info= new world_user_map_show_info_t();
			user_info.readExternal(input)			
		}
	}
}