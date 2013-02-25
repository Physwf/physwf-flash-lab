package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_drop_drop_group_t implements IExternalizable
	{
		public var probility:uint;
		public var loop:uint;
		public var item:Vector.<xml_drop_drop_group_item_t>;
		
		public function xml_drop_drop_group_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			probility = input.readUnsignedShort();
			loop = input.readUnsignedShort();
			var itemLen:uint =input.readUnsignedInt();
			item= new Vector.<xml_drop_drop_group_item_t>();
			for(var i:int=0;i<itemLen;++i)
			{
				var item_item:xml_drop_drop_group_item_t = new xml_drop_drop_group_item_t()
				item_item.readExternal(input);;
				item.push(item_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(probility);
			output.writeShort(loop);
			output.writeUnsignedInt(item.length);
			for(var j:int=0;j<item.length;++j)
			{
				item[j].writeExternal(output);
			}			
		}
	}
}