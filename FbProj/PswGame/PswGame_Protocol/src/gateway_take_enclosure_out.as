package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class gateway_take_enclosure_out implements IExternalizable
	{
		public var mail_id:uint;
		
		public function gateway_take_enclosure_out()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			mail_id = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(mail_id);			
		}
	}
}