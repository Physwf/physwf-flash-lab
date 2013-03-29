package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_skillupgrade_t implements IExternalizable
	{
		public var skillupgrade:Vector.<xml_skillup_skillup_t>;
		
		public function xml_skillupgrade_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var skillupgradeLen:uint =input.readUnsignedInt();
			skillupgrade= new Vector.<xml_skillup_skillup_t>();
			for(var i:int=0;i<skillupgradeLen;++i)
			{
				var skillupgrade_item:xml_skillup_skillup_t = new xml_skillup_skillup_t()
				skillupgrade_item.readExternal(input);;
				skillupgrade.push(skillupgrade_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(skillupgrade.length);
			for(var j:int=0;j<skillupgrade.length;++j)
			{
				skillupgrade[j].writeExternal(output);
			}			
		}
	}
}