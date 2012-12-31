package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class recommend_svrs_t implements IExternalizable
	{
		public var online_id:uint;
		public var online_ip:String;
		public var online_port:uint;
		public var user_num:uint;
		public var friend_num:uint;
		public var is_new_comer_svr:uint;
		
		public function recommend_svrs_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			online_id = input.readUnsignedShort();
			online_ip = input.readUTFBytes(16);
			online_port = input.readUnsignedShort();
			user_num = input.readUnsignedInt();
			friend_num = input.readUnsignedByte();
			is_new_comer_svr = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(online_id);
			var online_ipData:ByteArray = new ByteArray();
			online_ipData.writeUTFBytes(online_ip)
			online_ipData.length = 16;
			output.writeBytes(online_ipData)
			output.writeShort(online_port);
			output.writeInt(user_num);
			output.writeByte(friend_num);
			output.writeByte(is_new_comer_svr);			
		}
	}
}