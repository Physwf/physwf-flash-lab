package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class mail_enclosure_t implements IExternalizable
	{
		public var items_enclosure:Vector.<item_enclosure_t>;
		public var equips_enclosure:Vector.<equip_enclosure_t>;
		
		public function mail_enclosure_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var items_enclosureLen:uint =input.readUnsignedInt();
			items_enclosure= new Vector.<item_enclosure_t>();
			for(var i:int=0;i<items_enclosureLen;++i)
			{
				var items_enclosure_item:item_enclosure_t = new item_enclosure_t()
				items_enclosure_item.readExternal(input);;
				items_enclosure.push(items_enclosure_item);
			}
			var equips_enclosureLen:uint =input.readUnsignedInt();
			equips_enclosure= new Vector.<equip_enclosure_t>();
			for(var k:int=0;k<equips_enclosureLen;++k)
			{
				var equips_enclosure_item:equip_enclosure_t = new equip_enclosure_t()
				equips_enclosure_item.readExternal(input);;
				equips_enclosure.push(equips_enclosure_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(items_enclosure.length);
			for(var j:int=0;j<items_enclosure.length;++j)
			{
				items_enclosure[j].writeExternal(output);
			}
			output.writeUnsignedInt(equips_enclosure.length);
			for(var p:int=0;p<equips_enclosure.length;++p)
			{
				equips_enclosure[p].writeExternal(output);
			}			
		}
	}
}