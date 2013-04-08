package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_skillupgrade_t implements IExternalizable
	{
		public var skillupgrades:Vector.<xml_skillup_skillup_t>;
		
		public function xml_skillupgrade_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var skillupgradesLen:uint =input.readUnsignedInt();
			skillupgrades= new Vector.<xml_skillup_skillup_t>();
			for(var i:int=0;i<skillupgradesLen;++i)
			{
				var skillupgrades_item:xml_skillup_skillup_t = new xml_skillup_skillup_t()
				skillupgrades_item.readExternal(input);;
				skillupgrades.push(skillupgrades_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(skillupgrades.length);
			for(var j:int=0;j<skillupgrades.length;++j)
			{
				skillupgrades[j].writeExternal(output);
			}			
		}
	}
}