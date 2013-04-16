package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_rank_usr_t implements IExternalizable
	{
		public var user_id:uint;
		public var role_tm:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var sex:uint;
		public var prof:uint;
		public var league:String;
		public var league_data:ByteArray
		public var adore_times:uint;
		
		public function stru_rank_usr_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			user_id = input.readUnsignedInt();
			role_tm = input.readUnsignedInt();
			nick = input.readUTFBytes(16);
			sex = input.readUnsignedByte();
			prof = input.readUnsignedByte();
			league = input.readUTFBytes(16);
			adore_times = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(user_id);
			output.writeUnsignedInt(role_tm);
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
			output.writeByte(sex);
			output.writeByte(prof);
			if(league_data)
			{
				output.writeBytes(league_data)
			}
			else
			{
				var leagueData:ByteArray = new ByteArray();
				leagueData.writeUTFBytes(league)
				leagueData.length = 16;
				output.writeBytes(leagueData)
			}
			output.writeUnsignedInt(adore_times);			
		}
	}
}