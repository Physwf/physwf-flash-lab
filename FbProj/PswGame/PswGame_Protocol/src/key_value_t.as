package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class key_value_t implements IExternalizable
	{
		public var key:uint;
		public var value:uint;
		
		public function key_value_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			key = input.readUnsignedInt();
			value = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(key);
			output.writeUnsignedInt(value);			
		}
	}
}