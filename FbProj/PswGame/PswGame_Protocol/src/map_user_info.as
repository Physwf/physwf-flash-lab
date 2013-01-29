package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class map_user_info implements IExternalizable
	{
		public var userid:uint;
		public var role_tm:uint;
		public var model:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var mapid:uint;
		public var map_x:uint;
		public var map_y:uint;
		public var pet_follow:stru_pet_simple_t;
		public var equips:Vector.<uint>;
		
		public function map_user_info()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			userid = input.readUnsignedInt();
			role_tm = input.readUnsignedInt();
			model = input.readUnsignedInt();
			nick = input.readUTFBytes(16);
			mapid = input.readUnsignedInt();
			map_x = input.readUnsignedInt();
			map_y = input.readUnsignedInt();
			pet_follow= new stru_pet_simple_t();
			pet_follow.readExternal(input)
			equips= new Vector.<uint>();
			for(var i:int=0;i<16;++i)
			{
				var equips_item:uint = input.readUnsignedInt();
				equips.push(equips_item)
			}
			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(userid);
			output.writeUnsignedInt(role_tm);
			output.writeUnsignedInt(model);
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
			output.writeUnsignedInt(mapid);
			output.writeUnsignedInt(map_x);
			output.writeUnsignedInt(map_y);
			pet_follow.writeExternal(output)
			for(var i:int=0;i<16;++i)
			{
				output.writeUnsignedInt(equips[i])
			}
			
		}
	}
}