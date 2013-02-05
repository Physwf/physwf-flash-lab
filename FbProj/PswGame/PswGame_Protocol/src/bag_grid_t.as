package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class bag_grid_t implements IExternalizable
	{
		public var grid_id:uint;
		public var item_id:uint;
		public var item_cnt:uint;
		
		public function bag_grid_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			grid_id = input.readUnsignedShort();
			item_id = input.readUnsignedInt();
			item_cnt = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(grid_id);
			output.writeUnsignedInt(item_id);
			output.writeUnsignedInt(item_cnt);			
		}
	}
}