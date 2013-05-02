package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_UPDATE_HATCH_PET_NOTIFY_0x1020 extends MsgBase
	{
		public var pet:db_hatch_egg_t;
		
		public function MSG_RES_WORLD_UPDATE_HATCH_PET_NOTIFY_0x1020(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			pet= new db_hatch_egg_t();
			pet.readExternal(input)			
		}
	}
}