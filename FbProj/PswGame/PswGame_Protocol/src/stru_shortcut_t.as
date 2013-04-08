package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_shortcut_t implements IExternalizable
	{
		public var thing_id:uint;
		public var pos:uint;
		
		public function stru_shortcut_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			thing_id = input.readUnsignedInt();
			pos = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(thing_id);
			output.writeByte(pos);			
		}
	}
}