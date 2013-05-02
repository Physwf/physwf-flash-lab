package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class btl_unit_data_t implements IExternalizable
	{
		public var unit_type:uint;
		public var human:btl_human_t;
		public var pets:Vector.<btl_pet_t>;
		
		public function btl_unit_data_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			unit_type = input.readUnsignedByte();
			human= new btl_human_t();
			human.readExternal(input)
			var petsLen:uint =input.readUnsignedInt();
			pets= new Vector.<btl_pet_t>();
			for(var i:uint=0;i<petsLen;i++)
			{
				var pets_item:btl_pet_t = new btl_pet_t()
				pets_item.readExternal(input);;
				pets.push(pets_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeByte(unit_type);
			human.writeExternal(output)
			output.writeUnsignedInt(pets.length);
			for(var i:uint=0;i<pets.length;i++)
			{
				pets[i].writeExternal(output);
			}			
		}
	}
}