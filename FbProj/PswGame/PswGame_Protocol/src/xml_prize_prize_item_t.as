package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_prize_prize_item_t implements IExternalizable
	{
		public var id:uint;
		public var num:uint;
		
		public function xml_prize_prize_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			num = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(id);
			output.writeUnsignedInt(num);			
		}
	}
}