package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_LOGIN_1001 extends MsgBase
	{
		public var from_game:uint;
		public var to_game:uint;
		public var sess:String;
		public var tad:String;
		public var role_tm:uint;
		
		public function MSG_REQ_LOGIN_1001()
		{
			super(1001)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeInt(from_game);
			output.writeInt(to_game);
			var sessData:ByteArray = new ByteArray();
			sessData.writeUTFBytes(sess)
			sessData.length = 16;
			output.writeBytes(sessData)
			var tadData:ByteArray = new ByteArray();
			tadData.writeUTFBytes(tad)
			tadData.length = 64;
			output.writeBytes(tadData)
			output.writeInt(role_tm);			
		}
	}
}