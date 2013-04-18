package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SET_CUR_TITLE_1203 extends MsgBase
	{
		public var title_id:uint;
		public var flag:uint;
		
		public function MSG_REQ_SET_CUR_TITLE_1203()
		{
			super(1203)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(title_id);
			output.writeByte(flag);			
		}
	}
}