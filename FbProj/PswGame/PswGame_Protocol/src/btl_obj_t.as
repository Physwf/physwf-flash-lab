package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class btl_obj_t implements IExternalizable
	{
		public var obj_type:uint;
		public var obj_id:uint;
		public var obj_hp:uint;
		public var obj_mp:uint;
		public var flag:uint;
		
		public function btl_obj_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			obj_type = input.readUnsignedByte();
			obj_id = input.readUnsignedInt();
			obj_hp = input.readUnsignedInt();
			obj_mp = input.readUnsignedInt();
			flag = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeByte(obj_type);
			output.writeUnsignedInt(obj_id);
			output.writeUnsignedInt(obj_hp);
			output.writeUnsignedInt(obj_mp);
			output.writeByte(flag);			
		}
	}
}