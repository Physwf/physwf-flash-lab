package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_ROLE_CREATE_ROLE_0x9000 extends MsgBase
	{
		public var nick:String;
		public var nick_data:ByteArray
		public var sex:uint;
		
		public function MSG_REQ_ROLE_CREATE_ROLE_0x9000()
		{
			super(0x9000)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUTF(nick);
			output.writeByte(sex);			
		}
	}
}