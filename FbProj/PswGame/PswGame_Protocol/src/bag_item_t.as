package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class bag_item_t implements IExternalizable
	{
		public var item:stru_item_t;
		public var grid_tag:uint;
		
		public function bag_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			item= new stru_item_t();
			item.readExternal(input)
			grid_tag = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			item.writeExternal(output)
			output.writeShort(grid_tag);			
		}
	}
}