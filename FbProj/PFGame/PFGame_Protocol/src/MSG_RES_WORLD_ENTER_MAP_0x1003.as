package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_ENTER_MAP_0x1003 extends MsgBase
	{
		public var map_id:uint;
		public var pos:world_user_pos_t;
		
		public function MSG_RES_WORLD_ENTER_MAP_0x1003(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			map_id = input.readUnsignedInt();
			pos= new world_user_pos_t();
			pos.readExternal(input)			
		}
	}
}