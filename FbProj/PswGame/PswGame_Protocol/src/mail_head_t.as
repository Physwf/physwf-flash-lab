package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class mail_head_t implements IExternalizable
	{
		public var mail_id:uint;
		public var mail_state:uint;
		public var mail_type:uint;
		public var sender_id:uint;
		public var sender_role_tm:uint;
		public var sender_nick:String;
		public var sender_nick_data:ByteArray
		public var mail_title:String;
		public var mail_title_data:ByteArray
		
		public function mail_head_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			mail_id = input.readUnsignedInt();
			mail_state = input.readUnsignedInt();
			mail_type = input.readUnsignedInt();
			sender_id = input.readUnsignedInt();
			sender_role_tm = input.readUnsignedInt();
			sender_nick = input.readUTFBytes(16);
			mail_title = input.readUTFBytes(50);			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(mail_id);
			output.writeUnsignedInt(mail_state);
			output.writeUnsignedInt(mail_type);
			output.writeUnsignedInt(sender_id);
			output.writeUnsignedInt(sender_role_tm);
			if(sender_nick_data)
			{
				output.writeBytes(sender_nick_data)
			}
			else
			{
				var sender_nickData:ByteArray = new ByteArray();
				sender_nickData.writeUTFBytes(sender_nick)
				sender_nickData.length = 16;
				output.writeBytes(sender_nickData)
			}
			if(mail_title_data)
			{
				output.writeBytes(mail_title_data)
			}
			else
			{
				var mail_titleData:ByteArray = new ByteArray();
				mail_titleData.writeUTFBytes(mail_title)
				mail_titleData.length = 50;
				output.writeBytes(mail_titleData)
			}			
		}
	}
}