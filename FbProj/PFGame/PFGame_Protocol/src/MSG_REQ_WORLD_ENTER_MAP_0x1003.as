package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_ENTER_MAP_0x1003 extends MsgBase
	{
		public var map_id:uint;
		public var pos:world_user_pos_t;
		
		public function MSG_REQ_WORLD_ENTER_MAP_0x1003()
		{
			super(0x1003)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(map_id);
			pos.writeExternal(output)			
		}
	}
}