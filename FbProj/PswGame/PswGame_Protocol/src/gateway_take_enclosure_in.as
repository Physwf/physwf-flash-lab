package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class gateway_take_enclosure_in implements IExternalizable
	{
		public var mail_id:uint;
		public var enclosure:mail_enclosure_t;
		
		public function gateway_take_enclosure_in()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			mail_id = input.readUnsignedInt();
			enclosure= new mail_enclosure_t();
			enclosure.readExternal(input)			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(mail_id);
			enclosure.writeExternal(output)			
		}
	}
}