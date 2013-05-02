package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_egg_t implements IExternalizable
	{
		public var pos:uint;
		public var id:uint;
		public var quality:uint;
		
		public function db_egg_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			pos = input.readUnsignedInt();
			id = input.readUnsignedInt();
			quality = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(pos);
			output.writeUnsignedInt(id);
			output.writeByte(quality);			
		}
	}
}