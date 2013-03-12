package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class equip_enclosure_t implements IExternalizable
	{
		public var equip:stru_equip_t;
		public var end_time:uint;
		
		public function equip_enclosure_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			equip= new stru_equip_t();
			equip.readExternal(input)
			end_time = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			equip.writeExternal(output)
			output.writeUnsignedInt(end_time);			
		}
	}
}