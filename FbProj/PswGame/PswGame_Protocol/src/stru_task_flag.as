package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_task_flag implements IExternalizable
	{
		public var tskid:uint;
		public var flag:uint;
		
		public function stru_task_flag()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			tskid = input.readUnsignedInt();
			flag = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(tskid);
			output.writeUnsignedInt(flag);			
		}
	}
}