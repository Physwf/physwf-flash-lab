package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_BTL_END_NOTIFY_0x1402 extends MsgBase
	{
		public var ret:uint;
		public var pets:Vector.<btl_ret_pet_t>;
		public var add_items:Vector.<db_base_item_t>;
		
		public function MSG_RES_WORLD_USER_BTL_END_NOTIFY_0x1402(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			ret = input.readUnsignedByte();
			var petsLen:uint =input.readUnsignedInt();
			pets= new Vector.<btl_ret_pet_t>();
			for(var i:uint=0;i<petsLen;i++)
			{
				var pets_item:btl_ret_pet_t = new btl_ret_pet_t()
				pets_item.readExternal(input);;
				pets.push(pets_item);
			}
			var add_itemsLen:uint =input.readUnsignedInt();
			add_items= new Vector.<db_base_item_t>();
			for(i=0;i<add_itemsLen;i++)
			{
				var add_items_item:db_base_item_t = new db_base_item_t()
				add_items_item.readExternal(input);;
				add_items.push(add_items_item);
			}			
		}
	}
}