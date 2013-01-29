package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class base_attr_t implements IExternalizable
	{
		public var strength:uint;
		public var solar:uint;
		public var physique:uint;
		public var spirit:uint;
		public var agility:uint;
		
		public function base_attr_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			strength = input.readUnsignedShort();
			solar = input.readUnsignedShort();
			physique = input.readUnsignedShort();
			spirit = input.readUnsignedShort();
			agility = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(strength);
			output.writeShort(solar);
			output.writeShort(physique);
			output.writeShort(spirit);
			output.writeShort(agility);			
		}
	}
}