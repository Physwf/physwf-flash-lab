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
		public var sess_data:ByteArray
		public var tad:String;
		public var tad_data:ByteArray
		public var role_tm:uint;
		
		public function MSG_REQ_LOGIN_1001()
		{
			super(1001)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeInt(from_game);
			output.writeInt(to_game);
			if(sess_data)
			{
				output.writeBytes(sess_data)
			}
			else
			{
				var sessData:ByteArray = new ByteArray();
				sessData.writeUTFBytes(sess)
				sessData.length = 16;
				output.writeBytes(sessData)
			}
			if(tad_data)
			{
				output.writeBytes(tad_data)
			}
			else
			{
				var tadData:ByteArray = new ByteArray();
				tadData.writeUTFBytes(tad)
				tadData.length = 64;
				output.writeBytes(tadData)
			}
			output.writeInt(role_tm);			
		}
	}
}