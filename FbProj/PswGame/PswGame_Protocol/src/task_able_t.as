package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class task_able_t implements IExternalizable
	{
		public var tskid:uint;
		public var able:uint;
		
		public function task_able_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			tskid = input.readUnsignedInt();
			able = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(tskid);
			output.writeInt(able);			
		}
	}
}