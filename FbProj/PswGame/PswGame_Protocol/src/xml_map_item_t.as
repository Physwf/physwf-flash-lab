package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_map_item_t implements IExternalizable
	{
		public var id:uint;
		public var width:uint;
		public var height:uint;
		public var monster:Vector.<xml_map_item_monster_t>;
		
		public function xml_map_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			width = input.readUnsignedShort();
			height = input.readUnsignedInt();
			var monsterLen:uint =input.readUnsignedInt();
			monster= new Vector.<xml_map_item_monster_t>();
			for(var i:int=0;i<monsterLen;++i)
			{
				var monster_item:xml_map_item_monster_t = new xml_map_item_monster_t()
				monster_item.readExternal(input);;
				monster.push(monster_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(id);
			output.writeShort(width);
			output.writeUnsignedInt(height);
			output.writeUnsignedInt(monster.length);
			for(var j:int=0;j<monster.length;++j)
			{
				monster[j].writeExternal(output);
			}			
		}
	}
}