package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_pet_equipment_t implements IExternalizable
	{
		public var id:uint;
		public var pos:uint;
		public var pet_key:uint;
		public var level:uint;
		public var hole1:uint;
		public var hole2:uint;
		public var hole3:uint;
		public var hole4:uint;
		public var hole5:uint;
		public var additions:Vector.<db_pet_equipment_addition_t>;
		
		public function db_pet_equipment_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			pos = input.readUnsignedInt();
			pet_key = input.readUnsignedInt();
			level = input.readUnsignedByte();
			hole1 = input.readUnsignedInt();
			hole2 = input.readUnsignedInt();
			hole3 = input.readUnsignedInt();
			hole4 = input.readUnsignedInt();
			hole5 = input.readUnsignedInt();
			var additionsLen:uint =input.readUnsignedInt();
			additions= new Vector.<db_pet_equipment_addition_t>();
			for(var i:uint=0;i<additionsLen;i++)
			{
				var additions_item:db_pet_equipment_addition_t = new db_pet_equipment_addition_t()
				additions_item.readExternal(input);;
				additions.push(additions_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(id);
			output.writeUnsignedInt(pos);
			output.writeUnsignedInt(pet_key);
			output.writeByte(level);
			output.writeUnsignedInt(hole1);
			output.writeUnsignedInt(hole2);
			output.writeUnsignedInt(hole3);
			output.writeUnsignedInt(hole4);
			output.writeUnsignedInt(hole5);
			output.writeUnsignedInt(additions.length);
			for(var i:uint=0;i<additions.length;i++)
			{
				additions[i].writeExternal(output);
			}			
		}
	}
}