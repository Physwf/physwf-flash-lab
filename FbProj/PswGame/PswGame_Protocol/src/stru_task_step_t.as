package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_task_step_t implements IExternalizable
	{
		public var step:uint;
		public var flag:uint;
		public var value:uint;
		
		public function stru_task_step_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			step = input.readUnsignedShort();
			flag = input.readUnsignedByte();
			value = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(step);
			output.writeByte(flag);
			output.writeUnsignedInt(value);			
		}
	}
}