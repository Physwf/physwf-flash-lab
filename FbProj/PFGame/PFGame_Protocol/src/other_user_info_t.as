package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class other_user_info_t implements IExternalizable
	{
		public var uid:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var sex:uint;
		public var shengwang:uint;
		public var meili:uint;
		public var yueli:uint;
		public var exp:uint;
		
		public function other_user_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			uid = input.readUnsignedInt();
			nick = input.readUTF();
			sex = input.readUnsignedByte();
			shengwang = input.readUnsignedInt();
			meili = input.readUnsignedInt();
			yueli = input.readUnsignedInt();
			exp = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);
			output.writeUTF(nick);
			output.writeByte(sex);
			output.writeUnsignedInt(shengwang);
			output.writeUnsignedInt(meili);
			output.writeUnsignedInt(yueli);
			output.writeUnsignedInt(exp);			
		}
	}
}