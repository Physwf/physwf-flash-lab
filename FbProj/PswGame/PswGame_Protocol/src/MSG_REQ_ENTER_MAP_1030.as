package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_ENTER_MAP_1030 extends MsgBase
	{
		public var role_tm:uint;
		public var map_id:uint;
		public var map_x:uint;
		public var map_y:uint;
		
		public function MSG_REQ_ENTER_MAP_1030()
		{
			super(1030)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(role_tm);
			output.writeUnsignedInt(map_id);
			output.writeUnsignedInt(map_x);
			output.writeUnsignedInt(map_y);			
		}
	}
}