package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class gateway_send_mail_with_enclosure_out implements IExternalizable
	{
		public var recv_id:uint;
		public var recv_role_tm:uint;
		
		public function gateway_send_mail_with_enclosure_out()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			recv_id = input.readUnsignedInt();
			recv_role_tm = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(recv_id);
			output.writeUnsignedInt(recv_role_tm);			
		}
	}
}