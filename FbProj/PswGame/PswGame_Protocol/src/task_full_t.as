package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class task_full_t implements IExternalizable
	{
		public var tskid:uint;
		public var flag:uint;
		public var buff:String;
		
		public function task_full_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			tskid = input.readUnsignedInt();
			flag = input.readUnsignedInt();
			var buffLen:uint =input.readUnsignedInt();
			buff=input.readUTFBytes(buffLen);			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(tskid);
			output.writeInt(flag);
			output.writeUnsignedInt(buff.length);
			output.writeUTFBytes(buff);			
		}
	}
}