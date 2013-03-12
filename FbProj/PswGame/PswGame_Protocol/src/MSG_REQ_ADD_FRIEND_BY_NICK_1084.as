package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_ADD_FRIEND_BY_NICK_1084 extends MsgBase
	{
		public var nick:String;
		public var nick_data:ByteArray
		
		public function MSG_REQ_ADD_FRIEND_BY_NICK_1084()
		{
			super(1084)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
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
		}
	}
}