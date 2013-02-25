package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_monster_t implements IExternalizable
	{
		public var monster:Vector.<xml_monster_monster_t>;
		
		public function xml_monster_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var monsterLen:uint =input.readUnsignedInt();
			monster= new Vector.<xml_monster_monster_t>();
			for(var i:int=0;i<monsterLen;++i)
			{
				var monster_item:xml_monster_monster_t = new xml_monster_monster_t()
				monster_item.readExternal(input);;
				monster.push(monster_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(monster.length);
			for(var j:int=0;j<monster.length;++j)
			{
				monster[j].writeExternal(output);
			}			
		}
	}
}