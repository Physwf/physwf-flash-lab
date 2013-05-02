package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_REQ_FETCH_ATTACHMENT_0x1318 extends MsgBase
	{
		public var sn:uint;
		
		public function MSG_RES_WORLD_USER_REQ_FETCH_ATTACHMENT_0x1318(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			sn = input.readUnsignedInt();			
		}
	}
}