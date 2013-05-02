package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_friend_t implements IExternalizable
	{
		public var uid:uint;
		public var relation:uint;
		
		public function db_friend_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			uid = input.readUnsignedInt();
			relation = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);
			output.writeByte(relation);			
		}
	}
}