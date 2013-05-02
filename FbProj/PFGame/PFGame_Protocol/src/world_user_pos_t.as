package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class world_user_pos_t implements IExternalizable
	{
		public var x:uint;
		public var y:uint;
		
		public function world_user_pos_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			x = input.readUnsignedShort();
			y = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(x);
			output.writeShort(y);			
		}
	}
}