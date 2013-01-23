package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_MAP_MONSTERS_1038 extends MsgBase
	{
		public var monsters:Vector.<map_monster_t>;
		
		public function MSG_RES_GET_MAP_MONSTERS_1038(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var monstersLen:uint =input.readUnsignedInt();
			monsters= new Vector.<map_monster_t>();
			for(var i:int=0;i<monstersLen;++i)
			{
				var monsters_item:map_monster_t = new map_monster_t()
				monsters_item.readExternal(input);;
				monsters.push(monsters_item);
			}			
		}
	}
}