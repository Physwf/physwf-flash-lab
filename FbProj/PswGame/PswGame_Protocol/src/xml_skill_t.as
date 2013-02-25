package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_skill_t implements IExternalizable
	{
		public var skill:Vector.<xml_skill_skill_t>;
		
		public function xml_skill_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var skillLen:uint =input.readUnsignedInt();
			skill= new Vector.<xml_skill_skill_t>();
			for(var i:int=0;i<skillLen;++i)
			{
				var skill_item:xml_skill_skill_t = new xml_skill_skill_t()
				skill_item.readExternal(input);;
				skill.push(skill_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(skill.length);
			for(var j:int=0;j<skill.length;++j)
			{
				skill[j].writeExternal(output);
			}			
		}
	}
}