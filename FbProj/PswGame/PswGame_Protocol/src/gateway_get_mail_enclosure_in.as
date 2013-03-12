package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class gateway_get_mail_enclosure_in implements IExternalizable
	{
		public var items:Vector.<bag_item_t>;
		
		public function gateway_get_mail_enclosure_in()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var itemsLen:uint =input.readUnsignedInt();
			items= new Vector.<bag_item_t>();
			for(var i:int=0;i<itemsLen;++i)
			{
				var items_item:bag_item_t = new bag_item_t()
				items_item.readExternal(input);;
				items.push(items_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(items.length);
			for(var j:int=0;j<items.length;++j)
			{
				items[j].writeExternal(output);
			}			
		}
	}
}