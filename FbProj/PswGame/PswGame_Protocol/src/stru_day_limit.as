package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_day_limit implements IExternalizable
	{
		public var ssid:uint;
		public var count:uint;
		
		public function stru_day_limit()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			ssid = input.readUnsignedInt();
			count = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(ssid);
			output.writeUnsignedInt(count);			
		}
	}
}