package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class score_item_t implements IExternalizable
	{
		public var userid:uint;
		public var role_tm:uint;
		public var score:uint;
		
		public function score_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			userid = input.readUnsignedInt();
			role_tm = input.readUnsignedInt();
			score = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(userid);
			output.writeUnsignedInt(role_tm);
			output.writeUnsignedInt(score);			
		}
	}
}