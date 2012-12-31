package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class player_base_attr_t implements IExternalizable
	{
		public var hp:uint;
		public var atk:uint;
		public var crit:uint;
		public var fight_ability:uint;
		
		public function player_base_attr_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			hp = input.readUnsignedInt();
			atk = input.readUnsignedInt();
			crit = input.readUnsignedInt();
			fight_ability = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(hp);
			output.writeInt(atk);
			output.writeInt(crit);
			output.writeInt(fight_ability);			
		}
	}
}