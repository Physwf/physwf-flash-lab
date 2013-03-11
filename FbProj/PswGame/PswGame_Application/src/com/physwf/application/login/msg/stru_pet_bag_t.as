package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_pet_bag_t implements IExternalizable
	{
		public var instance_id:uint;
		public var pet_id:uint;
		public var nick:String;
		public var nick_data:ByteArray
		
		public function stru_pet_bag_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			instance_id = input.readUnsignedInt();
			pet_id = input.readUnsignedInt();
			nick = input.readUTFBytes(16);			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(instance_id);
			output.writeUnsignedInt(pet_id);
			if(nick_data)
			{
				output.writeBytes(nick_data)
			}
			else
			{
				var nickData:ByteArray = new ByteArray();
				nickData.writeUTFBytes(nick)
				nickData.length = 16;
				output.writeBytes(nickData)
			}			
		}
	}
}