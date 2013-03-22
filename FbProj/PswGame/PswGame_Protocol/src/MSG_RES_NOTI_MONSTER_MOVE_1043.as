package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_MONSTER_MOVE_1043 extends MsgBase
	{
		public var monster_instance_id:uint;
		public var face:uint;
		public var move_list:Vector.<map_pos_t>;
		
		public function MSG_RES_NOTI_MONSTER_MOVE_1043(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			monster_instance_id = input.readUnsignedInt();
			face = input.readUnsignedByte();
			var move_listLen:uint =input.readUnsignedInt();
			move_list= new Vector.<map_pos_t>();
			for(var i:int=0;i<move_listLen;++i)
			{
				var move_list_item:map_pos_t = new map_pos_t()
				move_list_item.readExternal(input);;
				move_list.push(move_list_item);
			}			
		}
	}
}