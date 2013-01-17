package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_skill_item_t implements IExternalizable
	{
		public var skill_id:uint;
		
		public function xml_skill_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			skill_id = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(skill_id);			
		}
	}
}