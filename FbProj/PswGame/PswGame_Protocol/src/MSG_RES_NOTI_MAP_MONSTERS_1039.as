package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_MAP_MONSTERS_1039 extends MsgBase
	{
		public var monsters:map_monster_t;
		
		public function MSG_RES_NOTI_MAP_MONSTERS_1039(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			monsters= new map_monster_t();
			monsters.readExternal(input)			
		}
	}
}