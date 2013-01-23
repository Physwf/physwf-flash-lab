package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_monster_item_t implements IExternalizable
	{
		public var monster_id:uint;
		public var atk:uint;
		public var def:uint;
		
		public function xml_monster_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			monster_id = input.readUnsignedShort();
			atk = input.readUnsignedInt();
			def = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(monster_id);
			output.writeUnsignedInt(atk);
			output.writeUnsignedInt(def);			
		}
	}
}