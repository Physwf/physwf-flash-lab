package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_PICK_UP_ITEM_1056 extends MsgBase
	{
		public var monster_id:uint;
		public var items:Vector.<xml_drop_drop_group_item_t>;
		
		public function MSG_RES_PICK_UP_ITEM_1056(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			monster_id = input.readUnsignedInt();
			var itemsLen:uint =input.readUnsignedInt();
			items= new Vector.<xml_drop_drop_group_item_t>();
			for(var i:int=0;i<itemsLen;++i)
			{
				var items_item:xml_drop_drop_group_item_t = new xml_drop_drop_group_item_t()
				items_item.readExternal(input);;
				items.push(items_item);
			}			
		}
	}
}