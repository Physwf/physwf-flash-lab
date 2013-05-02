package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_PET_CHANGE_NAME_0x1011 extends MsgBase
	{
		public var key:uint;
		public var nick:String;
		public var nick_data:ByteArray
		
		public function MSG_REQ_WORLD_PET_CHANGE_NAME_0x1011()
		{
			super(0x1011)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(key);
			output.writeUTF(nick);			
		}
	}
}