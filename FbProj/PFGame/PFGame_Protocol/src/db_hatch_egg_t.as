package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_hatch_egg_t implements IExternalizable
	{
		public var pos:uint;
		public var id:uint;
		public var gold:uint;
		public var luck:uint;
		public var expire_time:uint;
		public var quality:uint;
		
		public function db_hatch_egg_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			pos = input.readUnsignedByte();
			id = input.readUnsignedInt();
			gold = input.readUnsignedByte();
			luck = input.readUnsignedByte();
			expire_time = input.readUnsignedInt();
			quality = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeByte(pos);
			output.writeUnsignedInt(id);
			output.writeByte(gold);
			output.writeByte(luck);
			output.writeUnsignedInt(expire_time);
			output.writeByte(quality);			
		}
	}
}