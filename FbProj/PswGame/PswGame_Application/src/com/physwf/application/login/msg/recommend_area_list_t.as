package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class recommend_area_list_t implements IExternalizable
	{
		public var online_id:uint;
		public var online_ip:String;
		public var online_ip_data:ByteArray
		public var online_port:uint;
		public var user_num:uint;
		public var area_id:uint;
		
		public function recommend_area_list_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			online_id = input.readUnsignedShort();
			online_ip = input.readUTFBytes(16);
			online_port = input.readUnsignedShort();
			user_num = input.readUnsignedInt();
			area_id = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(online_id);
			if(online_ip_data)
			{
				output.writeBytes(online_ip_data)
			}
			else
			{
				var online_ipData:ByteArray = new ByteArray();
				online_ipData.writeUTFBytes(online_ip)
				online_ipData.length = 16;
				output.writeBytes(online_ipData)
			}
			output.writeShort(online_port);
			output.writeInt(user_num);
			output.writeShort(area_id);			
		}
	}
}