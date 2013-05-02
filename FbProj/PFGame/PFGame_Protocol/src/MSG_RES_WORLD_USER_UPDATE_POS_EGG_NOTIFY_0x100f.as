package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_UPDATE_POS_EGG_NOTIFY_0x100f extends MsgBase
	{
		public var data:db_egg_t;
		public var cnt:uint;
		
		public function MSG_RES_WORLD_USER_UPDATE_POS_EGG_NOTIFY_0x100f(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			data= new db_egg_t();
			data.readExternal(input)
			cnt = input.readUnsignedByte();			
		}
	}
}