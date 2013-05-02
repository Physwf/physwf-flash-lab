package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class world_user_cnt_info_t implements IExternalizable
	{
		public var world_id:uint;
		public var user_cnt:uint;
		
		public function world_user_cnt_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			world_id = input.readUnsignedInt();
			user_cnt = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(world_id);
			output.writeUnsignedInt(user_cnt);			
		}
	}
}