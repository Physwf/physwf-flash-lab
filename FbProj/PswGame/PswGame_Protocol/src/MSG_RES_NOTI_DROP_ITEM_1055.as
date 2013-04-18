package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_DROP_ITEM_1055 extends MsgBase
	{
		public var instance_id:uint;
		public var monster_id:uint;
		public var map_x:uint;
		public var map_y:uint;
		public var items:Vector.<xml_drop_drop_group_item_t>;
		public var item_last:uint;
		public var pet_id:uint;
		
		public function MSG_RES_NOTI_DROP_ITEM_1055(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			instance_id = input.readUnsignedInt();
			monster_id = input.readUnsignedShort();
			map_x = input.readUnsignedShort();
			map_y = input.readUnsignedShort();
			var itemsLen:uint =input.readUnsignedInt();
			items= new Vector.<xml_drop_drop_group_item_t>();
			for(var i:int=0;i<itemsLen;++i)
			{
				var items_item:xml_drop_drop_group_item_t = new xml_drop_drop_group_item_t()
				items_item.readExternal(input);;
				items.push(items_item);
			}
			item_last = input.readUnsignedInt();
			pet_id = input.readUnsignedShort();			
		}
	}
}