package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class btl_pet_end_t implements IExternalizable
	{
		public var pet_key:uint;
		public var use_skills:Vector.<btl_pet_use_skill_t>;
		
		public function btl_pet_end_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			pet_key = input.readUnsignedInt();
			var use_skillsLen:uint =input.readUnsignedInt();
			use_skills= new Vector.<btl_pet_use_skill_t>();
			for(var i:uint=0;i<use_skillsLen;i++)
			{
				var use_skills_item:btl_pet_use_skill_t = new btl_pet_use_skill_t()
				use_skills_item.readExternal(input);;
				use_skills.push(use_skills_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(pet_key);
			output.writeUnsignedInt(use_skills.length);
			for(var i:uint=0;i<use_skills.length;i++)
			{
				use_skills[i].writeExternal(output);
			}			
		}
	}
}