package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_map_t implements IExternalizable
	{
		public var items:Vector.<xml_map_item_t>;
		
		public function xml_map_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var itemsLen:uint =input.readUnsignedInt();
			items= new Vector.<xml_map_item_t>();
			for(var i:int=0;i<itemsLen;++i)
			{
				var items_item:xml_map_item_t = new xml_map_item_t()
				items_item.readExternal(input);;
				items.push(items_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(items.length);
			for(var i:int=0;i<items.length;++i)
			{
				items[i].writeExternal(output);
			}			
		}
	}
}