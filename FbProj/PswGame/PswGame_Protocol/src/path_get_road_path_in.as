package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class path_get_road_path_in implements IExternalizable
	{
		public var monster_instance_id:uint;
		public var monster_seqid:uint;
		public var map_instance_id:uint;
		public var map_type_id:uint;
		public var start_x:uint;
		public var start_y:uint;
		public var end_x:uint;
		public var end_y:uint;
		
		public function path_get_road_path_in()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			monster_instance_id = input.readUnsignedInt();
			monster_seqid = input.readUnsignedInt();
			map_instance_id = input.readUnsignedInt();
			map_type_id = input.readUnsignedInt();
			start_x = input.readUnsignedInt();
			start_y = input.readUnsignedInt();
			end_x = input.readUnsignedInt();
			end_y = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(monster_instance_id);
			output.writeUnsignedInt(monster_seqid);
			output.writeUnsignedInt(map_instance_id);
			output.writeUnsignedInt(map_type_id);
			output.writeUnsignedInt(start_x);
			output.writeUnsignedInt(start_y);
			output.writeUnsignedInt(end_x);
			output.writeUnsignedInt(end_y);			
		}
	}
}