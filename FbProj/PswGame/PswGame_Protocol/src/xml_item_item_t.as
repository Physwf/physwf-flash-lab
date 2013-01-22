package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_item_item_t implements IExternalizable
	{
		public var item_id:uint;
		public var category:uint;
		public var sell_price:uint;
		public var buy_price:uint;
		public var max_num:uint;
		public var trade_flag:uint;
		public var discard_flag:uint;
		public var accumulate:uint;
		public var duration_time:uint;
		public var function_id:uint;
		public var function_value:uint;
		
		public function xml_item_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			item_id = input.readUnsignedInt();
			category = input.readUnsignedByte();
			sell_price = input.readUnsignedInt();
			buy_price = input.readUnsignedInt();
			max_num = input.readUnsignedInt();
			trade_flag = input.readUnsignedInt();
			discard_flag = input.readUnsignedInt();
			accumulate = input.readUnsignedInt();
			duration_time = input.readUnsignedInt();
			function_id = input.readUnsignedInt();
			function_value = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(item_id);
			output.writeByte(category);
			output.writeUnsignedInt(sell_price);
			output.writeUnsignedInt(buy_price);
			output.writeUnsignedInt(max_num);
			output.writeUnsignedInt(trade_flag);
			output.writeUnsignedInt(discard_flag);
			output.writeUnsignedInt(accumulate);
			output.writeUnsignedInt(duration_time);
			output.writeUnsignedInt(function_id);
			output.writeUnsignedInt(function_value);			
		}
	}
}