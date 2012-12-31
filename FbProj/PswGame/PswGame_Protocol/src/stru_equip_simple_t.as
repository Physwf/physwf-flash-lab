package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_equip_simple_t implements IExternalizable
	{
		public var equip_id:uint;
		
		public function stru_equip_simple_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			equip_id = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(equip_id);			
		}
	}
}