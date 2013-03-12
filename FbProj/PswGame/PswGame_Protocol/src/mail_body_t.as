package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class mail_body_t implements IExternalizable
	{
		public var mail_content:msg_t;
		public var enclosure:mail_enclosure_t;
		
		public function mail_body_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			mail_content= new msg_t();
			mail_content.readExternal(input)
			enclosure= new mail_enclosure_t();
			enclosure.readExternal(input)			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			mail_content.writeExternal(output)
			enclosure.writeExternal(output)			
		}
	}
}