package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class gateway_noti_send_to_map_out implements IExternalizable
	{
		public var mapid:uint;
		public var exclude_userid:uint;
		public var msg:String;
		public var msg_data:ByteArray
		
		public function gateway_noti_send_to_map_out()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			mapid = input.readUnsignedInt();
			exclude_userid = input.readUnsignedInt();
			var msgLen:uint =input.readUnsignedInt();
			msg=input.readUTFBytes(msgLen);			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(mapid);
			output.writeUnsignedInt(exclude_userid);
			output.writeUnsignedInt(msg.length);
			output.writeUTFBytes(msg);			
		}
	}
}