package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class grid_group_t implements IExternalizable
	{
		public var group_type:uint;
		public var item_list:Vector.<bag_grid_t>;
		
		public function grid_group_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			group_type = input.readUnsignedInt();
			var item_listLen:uint =input.readUnsignedInt();
			item_list= new Vector.<bag_grid_t>();
			for(var i:int=0;i<item_listLen;++i)
			{
				var item_list_item:bag_grid_t = new bag_grid_t()
				item_list_item.readExternal(input);;
				item_list.push(item_list_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(group_type);
			output.writeUnsignedInt(item_list.length);
			for(var j:int=0;j<item_list.length;++j)
			{
				item_list[j].writeExternal(output);
			}			
		}
	}
}