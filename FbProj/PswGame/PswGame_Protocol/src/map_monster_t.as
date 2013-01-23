package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class map_monster_t implements IExternalizable
	{
		public var instance_id:uint;
		public var monster_id:uint;
		public var map_x:uint;
		public var map_y:uint;
		public var hp:uint;
		public var mp:uint;
		
		public function map_monster_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			instance_id = input.readUnsignedByte();
			monster_id = input.readUnsignedShort();
			map_x = input.readUnsignedShort();
			map_y = input.readUnsignedShort();
			hp = input.readUnsignedShort();
			mp = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeByte(instance_id);
			output.writeShort(monster_id);
			output.writeShort(map_x);
			output.writeShort(map_y);
			output.writeShort(hp);
			output.writeShort(mp);			
		}
	}
}