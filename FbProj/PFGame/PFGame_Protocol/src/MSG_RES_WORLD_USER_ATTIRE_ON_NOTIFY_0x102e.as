package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_ATTIRE_ON_NOTIFY_0x102e extends MsgBase
	{
		public var user_id:uint;
		public var attire_id:uint;
		
		public function MSG_RES_WORLD_USER_ATTIRE_ON_NOTIFY_0x102e(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_id = input.readUnsignedInt();
			attire_id = input.readUnsignedInt();			
		}
	}
}