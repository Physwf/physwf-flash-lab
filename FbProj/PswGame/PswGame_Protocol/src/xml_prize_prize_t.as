package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_prize_prize_t implements IExternalizable
	{
		public var id:uint;
		public var item:Vector.<xml_prize_prize_item_t>;
		
		public function xml_prize_prize_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedShort();
			var itemLen:uint =input.readUnsignedInt();
			item= new Vector.<xml_prize_prize_item_t>();
			for(var i:int=0;i<itemLen;++i)
			{
				var item_item:xml_prize_prize_item_t = new xml_prize_prize_item_t()
				item_item.readExternal(input);;
				item.push(item_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(id);
			output.writeUnsignedInt(item.length);
			for(var j:int=0;j<item.length;++j)
			{
				item[j].writeExternal(output);
			}			
		}
	}
}