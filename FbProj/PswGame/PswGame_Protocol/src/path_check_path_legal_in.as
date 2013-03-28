package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class path_check_path_legal_in implements IExternalizable
	{
		public var map_type_id:uint;
		public var map_x:uint;
		public var map_y:uint;
		
		public function path_check_path_legal_in()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			map_type_id = input.readUnsignedInt();
			map_x = input.readUnsignedInt();
			map_y = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(map_type_id);
			output.writeUnsignedInt(map_x);
			output.writeUnsignedInt(map_y);			
		}
	}
}