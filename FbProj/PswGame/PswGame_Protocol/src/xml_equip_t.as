package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_equip_t implements IExternalizable
	{
		public var equip:Vector.<xml_equip_equip_t>;
		
		public function xml_equip_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var equipLen:uint =input.readUnsignedInt();
			equip= new Vector.<xml_equip_equip_t>();
			for(var i:int=0;i<equipLen;++i)
			{
				var equip_item:xml_equip_equip_t = new xml_equip_equip_t()
				equip_item.readExternal(input);;
				equip.push(equip_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(equip.length);
			for(var j:int=0;j<equip.length;++j)
			{
				equip[j].writeExternal(output);
			}			
		}
	}
}