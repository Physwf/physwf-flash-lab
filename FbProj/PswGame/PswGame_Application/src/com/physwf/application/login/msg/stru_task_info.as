package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_task_info implements IExternalizable
	{
		public var task_id:uint;
		public var step:uint;
		public var flag:uint;
		public var value:uint;
		
		public function stru_task_info()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			task_id = input.readUnsignedShort();
			step = input.readUnsignedShort();
			flag = input.readUnsignedByte();
			value = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(task_id);
			output.writeShort(step);
			output.writeByte(flag);
			output.writeUnsignedInt(value);			
		}
	}
}