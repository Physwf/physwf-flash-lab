package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_USER_MOVE_1037 extends MsgBase
	{
		public var uid:uint;
		public var x:uint;
		public var y:uint;
		public var dir:uint;
		
		public function MSG_RES_NOTI_USER_MOVE_1037(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			uid = input.readUnsignedInt();
			x = input.readUnsignedInt();
			y = input.readUnsignedInt();
			dir = input.readUnsignedInt();			
		}
	}
}