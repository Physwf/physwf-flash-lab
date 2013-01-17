package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_BAG_1050 extends MsgBase
	{
		public var items:Vector.<stru_item_t>;
		public var equips:Vector.<stru_equip_t>;
		
		public function MSG_RES_GET_BAG_1050(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var itemsLen:uint =input.readUnsignedInt();
			items= new Vector.<stru_item_t>();
			for(var i:int=0;i<itemsLen;++i)
			{
				var items_item:stru_item_t = new stru_item_t()
				items_item.readExternal(input);;
				items.push(items_item);
			}
			var equipsLen:uint =input.readUnsignedInt();
			equips= new Vector.<stru_equip_t>();
			for(i=0;i<equipsLen;++i)
			{
				var equips_item:stru_equip_t = new stru_equip_t()
				equips_item.readExternal(input);;
				equips.push(equips_item);
			}			
		}
	}
}