package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_BAG_GRID_1053 extends MsgBase
	{
		public var items:Vector.<bag_item_t>;
		public var equips:Vector.<bag_equip_t>;
		
		public function MSG_RES_NOTI_BAG_GRID_1053(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var itemsLen:uint =input.readUnsignedInt();
			items= new Vector.<bag_item_t>();
			for(var i:int=0;i<itemsLen;++i)
			{
				var items_item:bag_item_t = new bag_item_t()
				items_item.readExternal(input);;
				items.push(items_item);
			}
			var equipsLen:uint =input.readUnsignedInt();
			equips= new Vector.<bag_equip_t>();
			for(var j:int=0;j<equipsLen;++j)
			{
				var equips_item:bag_equip_t = new bag_equip_t()
				equips_item.readExternal(input);;
				equips.push(equips_item);
			}			
		}
	}
}