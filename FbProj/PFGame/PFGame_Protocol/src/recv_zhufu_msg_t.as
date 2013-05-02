package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class recv_zhufu_msg_t implements IExternalizable
	{
		public var sn:uint;
		public var uid:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var world_id:uint;
		public var time:uint;
		public var item:uint;
		public var item_cnt:uint;
		public var gift:uint;
		public var gift_cnt:uint;
		
		public function recv_zhufu_msg_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			sn = input.readUnsignedInt();
			uid = input.readUnsignedInt();
			nick = input.readUTF();
			world_id = input.readUnsignedInt();
			time = input.readUnsignedInt();
			item = input.readUnsignedInt();
			item_cnt = input.readUnsignedInt();
			gift = input.readUnsignedInt();
			gift_cnt = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(sn);
			output.writeUnsignedInt(uid);
			output.writeUTF(nick);
			output.writeUnsignedInt(world_id);
			output.writeUnsignedInt(time);
			output.writeUnsignedInt(item);
			output.writeUnsignedInt(item_cnt);
			output.writeUnsignedInt(gift);
			output.writeUnsignedInt(gift_cnt);			
		}
	}
}