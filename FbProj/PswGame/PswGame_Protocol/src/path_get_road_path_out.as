package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class path_get_road_path_out implements IExternalizable
	{
		public var monster_instance_id:uint;
		public var monster_seqid:uint;
		public var map_instance_id:uint;
		public var map_type_id:uint;
		public var path_node_list:Vector.<path_node_t>;
		
		public function path_get_road_path_out()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			monster_instance_id = input.readUnsignedInt();
			monster_seqid = input.readUnsignedInt();
			map_instance_id = input.readUnsignedInt();
			map_type_id = input.readUnsignedInt();
			var path_node_listLen:uint =input.readUnsignedInt();
			path_node_list= new Vector.<path_node_t>();
			for(var i:int=0;i<path_node_listLen;++i)
			{
				var path_node_list_item:path_node_t = new path_node_t()
				path_node_list_item.readExternal(input);;
				path_node_list.push(path_node_list_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(monster_instance_id);
			output.writeUnsignedInt(monster_seqid);
			output.writeUnsignedInt(map_instance_id);
			output.writeUnsignedInt(map_type_id);
			output.writeUnsignedInt(path_node_list.length);
			for(var j:int=0;j<path_node_list.length;++j)
			{
				path_node_list[j].writeExternal(output);
			}			
		}
	}
}