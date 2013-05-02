package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_swap_pos_t implements IExternalizable
	{
		public var src_pos:uint;
		public var des_pos:uint;
		
		public function db_swap_pos_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			src_pos = input.readUnsignedInt();
			des_pos = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(src_pos);
			output.writeUnsignedInt(des_pos);			
		}
	}
}