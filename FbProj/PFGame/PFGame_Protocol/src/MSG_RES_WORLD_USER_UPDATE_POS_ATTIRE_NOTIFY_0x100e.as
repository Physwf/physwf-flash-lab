package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_UPDATE_POS_ATTIRE_NOTIFY_0x100e extends MsgBase
	{
		public var data:db_attire_t;
		public var cnt:uint;
		
		public function MSG_RES_WORLD_USER_UPDATE_POS_ATTIRE_NOTIFY_0x100e(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			data= new db_attire_t();
			data.readExternal(input)
			cnt = input.readUnsignedByte();			
		}
	}
}