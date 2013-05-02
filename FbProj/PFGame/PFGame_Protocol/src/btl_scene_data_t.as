package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class btl_scene_data_t implements IExternalizable
	{
		public var ele:uint;
		
		public function btl_scene_data_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			ele = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeByte(ele);			
		}
	}
}