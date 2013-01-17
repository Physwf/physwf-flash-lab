package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_item_t implements IExternalizable
	{
		public var item:Vector.<xml_item_item_t>;
		
		public function xml_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var itemLen:uint =input.readUnsignedInt();
			item= new Vector.<xml_item_item_t>();
			for(var i:int=0;i<itemLen;++i)
			{
				var item_item:xml_item_item_t = new xml_item_item_t()
				item_item.readExternal(input);;
				item.push(item_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(item.length);
			for(var i:int=0;i<item.length;++i)
			{
				item[i].writeExternal(output);
			}			
		}
	}
}