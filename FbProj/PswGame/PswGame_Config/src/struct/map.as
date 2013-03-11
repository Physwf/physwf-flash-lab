package templates
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	public class map implements IExternalizable
	{
		public var map_id:uint;
		public var map_name:String;
		public var planet_id:uint;
		public var born:String;
		
		
		public function map()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			map_id = input.readUnsignedByte();
			var map_nameLen:uint = input.readUnsignedShort();
			map_name = input.readUTFBytes(map_nameLen);
			planet_id = input.readUnsignedByte();
			var bornLen:uint = input.readUnsignedShort();
			born = input.readUTFBytes(bornLen);
			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeByte(map_id);
			var map_nameData:ByteArray = new ByteArray();
			map_nameData.writeUTFBytes(map_name);
			output.writeShort(map_nameData.length);
			output.writeBytes(map_nameData);
			output.writeByte(planet_id);
			var bornData:ByteArray = new ByteArray();
			bornData.writeUTFBytes(born);
			output.writeShort(bornData.length);
			output.writeBytes(bornData);
			
		}
		
	}
}