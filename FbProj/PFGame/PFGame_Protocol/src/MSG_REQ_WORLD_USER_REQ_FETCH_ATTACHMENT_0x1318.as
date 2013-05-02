package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_REQ_FETCH_ATTACHMENT_0x1318 extends MsgBase
	{
		public var sn:uint;
		
		public function MSG_REQ_WORLD_USER_REQ_FETCH_ATTACHMENT_0x1318()
		{
			super(0x1318)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(sn);			
		}
	}
}