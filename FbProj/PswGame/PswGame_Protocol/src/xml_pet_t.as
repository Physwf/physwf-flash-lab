package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_pet_t implements IExternalizable
	{
		public var pet:Vector.<xml_pet_pet_t>;
		
		public function xml_pet_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var petLen:uint =input.readUnsignedInt();
			pet= new Vector.<xml_pet_pet_t>();
			for(var i:int=0;i<petLen;++i)
			{
				var pet_item:xml_pet_pet_t = new xml_pet_pet_t()
				pet_item.readExternal(input);;
				pet.push(pet_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(pet.length);
			for(var j:int=0;j<pet.length;++j)
			{
				pet[j].writeExternal(output);
			}			
		}
	}
}