package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_skill_v implements IExternalizable
	{
		public var skills:Vector.<stru_skill_t>;
		
		public function stru_skill_v()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var skillsLen:uint =input.readUnsignedInt();
			skills= new Vector.<stru_skill_t>();
			for(var i:int=0;i<skillsLen;++i)
			{
				var skills_item:stru_skill_t = new stru_skill_t()
				skills_item.readExternal(input);;
				skills.push(skills_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(skills.length);
			for(var j:int=0;j<skills.length;++j)
			{
				skills[j].writeExternal(output);
			}			
		}
	}
}