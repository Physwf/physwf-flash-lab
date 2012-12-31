package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_task_info implements IExternalizable
	{
		public var tskid:uint;
		public var flag:uint;
		public var buff:String;
		
		public function stru_task_info()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			tskid = input.readUnsignedInt();
			flag = input.readUnsignedInt();
			buff = input.readUTFBytes(32);			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(tskid);
			output.writeInt(flag);
			var buffData:ByteArray = new ByteArray();
			buffData.writeUTFBytes(buff)
			buffData.length = 32;
			output.writeBytes(buffData)			
		}
	}
}