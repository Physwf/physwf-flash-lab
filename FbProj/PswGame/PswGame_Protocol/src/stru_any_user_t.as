package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_any_user_t implements IExternalizable
	{
		public var user_id:uint;
		public var sex:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var level:uint;
		public var prof:uint;
		public var title:String;
		public var title_data:ByteArray
		public var league:String;
		public var league_data:ByteArray
		public var partner:String;
		public var partner_data:ByteArray
		public var body_equips:Vector.<uint>;
		public var signature:String;
		public var signature_data:ByteArray
		
		public function stru_any_user_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			user_id = input.readUnsignedInt();
			sex = input.readUnsignedByte();
			nick = input.readUTFBytes(16);
			level = input.readUnsignedShort();
			prof = input.readUnsignedByte();
			title = input.readUTFBytes(16);
			league = input.readUTFBytes(16);
			partner = input.readUTFBytes(16);
			body_equips= new Vector.<uint>();
			for(var i:int=0;i<16;++i)
			{
				var body_equips_item:uint = input.readUnsignedShort();
				body_equips.push(body_equips_item)
			}

			var signatureLen:uint =input.readUnsignedInt();
			signature=input.readUTFBytes(signatureLen);			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(user_id);
			output.writeByte(sex);
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
			output.writeShort(level);
			output.writeByte(prof);
			if(title_data)
			{
				output.writeBytes(title_data)
			}
			else
			{
				var titleData:ByteArray = new ByteArray();
				titleData.writeUTFBytes(title)
				titleData.length = 16;
				output.writeBytes(titleData)
			}
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
			if(partner_data)
			{
				output.writeBytes(partner_data)
			}
			else
			{
				var partnerData:ByteArray = new ByteArray();
				partnerData.writeUTFBytes(partner)
				partnerData.length = 16;
				output.writeBytes(partnerData)
			}
			for(var j:int=0;j<16;++j)
			{
				output.writeShort(body_equips[j])
			}

			output.writeUnsignedInt(signature.length);
			output.writeUTFBytes(signature);			
		}
	}
}