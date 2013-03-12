package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class gateway_get_mail_enclosure_out implements IExternalizable
	{
		public var enclosure:mail_enclosure_t;
		
		public function gateway_get_mail_enclosure_out()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			enclosure= new mail_enclosure_t();
			enclosure.readExternal(input)			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			enclosure.writeExternal(output)			
		}
	}
}