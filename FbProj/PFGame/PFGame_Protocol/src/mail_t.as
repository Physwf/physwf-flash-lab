package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class mail_t implements IExternalizable
	{
		public var sn:uint;
		public var status:uint;
		public var title:String;
		public var title_data:ByteArray
		public var body:uint;
		public var create_time:uint;
		public var expire_time:uint;
		public var fetched:uint;
		public var item_id:uint;
		public var item_cnt:uint;
		public var map_id:uint;
		public var pos_x:uint;
		public var pos_y:uint;
		
		public function mail_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			sn = input.readUnsignedInt();
			status = input.readUnsignedByte();
			title = input.readUTF();
			body = input.readUnsignedInt();
			create_time = input.readUnsignedInt();
			expire_time = input.readUnsignedInt();
			fetched = input.readUnsignedByte();
			item_id = input.readUnsignedInt();
			item_cnt = input.readUnsignedInt();
			map_id = input.readUnsignedShort();
			pos_x = input.readUnsignedShort();
			pos_y = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(sn);
			output.writeByte(status);
			output.writeUTF(title);
			output.writeUnsignedInt(body);
			output.writeUnsignedInt(create_time);
			output.writeUnsignedInt(expire_time);
			output.writeByte(fetched);
			output.writeUnsignedInt(item_id);
			output.writeUnsignedInt(item_cnt);
			output.writeShort(map_id);
			output.writeShort(pos_x);
			output.writeShort(pos_y);			
		}
	}
}