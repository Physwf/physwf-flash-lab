package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_map_t implements IExternalizable
	{
		public var item:Vector.<xml_map_item_t>;
		
		public function xml_map_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var itemLen:uint =input.readUnsignedInt();
			item= new Vector.<xml_map_item_t>();
			for(var i:int=0;i<itemLen;++i)
			{
				var item_item:xml_map_item_t = new xml_map_item_t()
				item_item.readExternal(input);;
				item.push(item_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(item.length);
			for(var j:int=0;j<item.length;++j)
			{
				item[j].writeExternal(output);
			}			
		}
	}
}