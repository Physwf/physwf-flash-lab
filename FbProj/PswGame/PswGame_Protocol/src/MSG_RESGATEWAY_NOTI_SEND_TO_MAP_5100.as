package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RESGATEWAY_NOTI_SEND_TO_MAP_5100 extends MsgBase
	{
		public var mapid:uint;
		public var exclude_userid:uint;
		public var msg:String;
		public var msg_data:ByteArray
		
		public function MSG_RESGATEWAY_NOTI_SEND_TO_MAP_5100(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			mapid = input.readUnsignedInt();
			exclude_userid = input.readUnsignedInt();
			var msgLen:uint =input.readUnsignedInt();
			msg=input.readUTFBytes(msgLen);			
		}
	}
}