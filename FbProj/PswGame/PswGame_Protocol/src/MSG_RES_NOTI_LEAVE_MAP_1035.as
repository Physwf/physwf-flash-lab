package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_LEAVE_MAP_1035 extends MsgBase
	{
		public var user_id:uint;
		public var map_id:uint;
		
		public function MSG_RES_NOTI_LEAVE_MAP_1035(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_id = input.readUnsignedInt();
			map_id = input.readUnsignedInt();			
		}
	}
}