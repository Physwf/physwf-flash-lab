package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class map_pos_t implements IExternalizable
	{
		public var map_x:uint;
		public var map_y:uint;
		
		public function map_pos_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			map_x = input.readUnsignedShort();
			map_y = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(map_x);
			output.writeShort(map_y);			
		}
	}
}