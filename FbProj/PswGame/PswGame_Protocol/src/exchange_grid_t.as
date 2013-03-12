package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class exchange_grid_t implements IExternalizable
	{
		public var src:uint;
		public var obj:uint;
		
		public function exchange_grid_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			src = input.readUnsignedShort();
			obj = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(src);
			output.writeShort(obj);			
		}
	}
}