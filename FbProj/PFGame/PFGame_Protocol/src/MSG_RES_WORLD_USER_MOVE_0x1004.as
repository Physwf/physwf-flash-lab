package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_MOVE_0x1004 extends MsgBase
	{
		public var uid:uint;
		public var pos:world_user_pos_t;
		
		public function MSG_RES_WORLD_USER_MOVE_0x1004(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			uid = input.readUnsignedInt();
			pos= new world_user_pos_t();
			pos.readExternal(input)			
		}
	}
}