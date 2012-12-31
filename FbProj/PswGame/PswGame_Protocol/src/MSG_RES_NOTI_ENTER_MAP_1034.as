package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_ENTER_MAP_1034 extends MsgBase
	{
		public var user:map_user_info;
		
		public function MSG_RES_NOTI_ENTER_MAP_1034(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user= new map_user_info();
			user.readExternal(input)			
		}
	}
}