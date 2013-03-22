package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class role_detail_info implements IExternalizable
	{
		public var role_tm:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var sex:uint;
		public var prof:uint;
		public var level:uint;
		public var equips:Vector.<uint>;
		
		public function role_detail_info()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			role_tm = input.readUnsignedInt();
			nick = input.readUTFBytes(16);
			sex = input.readUnsignedByte();
			prof = input.readUnsignedByte();
			level = input.readUnsignedShort();
			equips= new Vector.<uint>();
			for(var i:int=0;i<16;++i)
			{
				var equips_item:uint = input.readUnsignedShort();
				equips.push(equips_item)
			}
			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
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
			output.writeShort(level);
			for(var j:int=0;j<16;++j)
			{
				output.writeShort(equips[j])
			}
			
		}
	}
}