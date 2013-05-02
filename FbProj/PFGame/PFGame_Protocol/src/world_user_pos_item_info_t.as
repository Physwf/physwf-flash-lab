package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class world_user_pos_item_info_t implements IExternalizable
	{
		public var pos_item_common:Vector.<db_item_t>;
		public var pos_item_attire:Vector.<db_attire_t>;
		public var pos_item_egg:Vector.<db_egg_t>;
		
		public function world_user_pos_item_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var pos_item_commonLen:uint =input.readUnsignedInt();
			pos_item_common= new Vector.<db_item_t>();
			for(var i:uint=0;i<pos_item_commonLen;i++)
			{
				var pos_item_common_item:db_item_t = new db_item_t()
				pos_item_common_item.readExternal(input);;
				pos_item_common.push(pos_item_common_item);
			}
			var pos_item_attireLen:uint =input.readUnsignedInt();
			pos_item_attire= new Vector.<db_attire_t>();
			for(i=0;i<pos_item_attireLen;i++)
			{
				var pos_item_attire_item:db_attire_t = new db_attire_t()
				pos_item_attire_item.readExternal(input);;
				pos_item_attire.push(pos_item_attire_item);
			}
			var pos_item_eggLen:uint =input.readUnsignedInt();
			pos_item_egg= new Vector.<db_egg_t>();
			for(i=0;i<pos_item_eggLen;i++)
			{
				var pos_item_egg_item:db_egg_t = new db_egg_t()
				pos_item_egg_item.readExternal(input);;
				pos_item_egg.push(pos_item_egg_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(pos_item_common.length);
			for(var i:uint=0;i<pos_item_common.length;i++)
			{
				pos_item_common[i].writeExternal(output);
			}
			output.writeUnsignedInt(pos_item_attire.length);
			for(i=0;i<pos_item_attire.length;i++)
			{
				pos_item_attire[i].writeExternal(output);
			}
			output.writeUnsignedInt(pos_item_egg.length);
			for(i=0;i<pos_item_egg.length;i++)
			{
				pos_item_egg[i].writeExternal(output);
			}			
		}
	}
}