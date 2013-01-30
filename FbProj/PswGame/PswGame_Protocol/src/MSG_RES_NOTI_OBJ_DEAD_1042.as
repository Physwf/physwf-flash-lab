package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_OBJ_DEAD_1042 extends MsgBase
	{
		public var obj_type:uint;
		public var obj_id:uint;
		
		public function MSG_RES_NOTI_OBJ_DEAD_1042(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			obj_type = input.readUnsignedByte();
			obj_id = input.readUnsignedInt();			
		}
	}
}