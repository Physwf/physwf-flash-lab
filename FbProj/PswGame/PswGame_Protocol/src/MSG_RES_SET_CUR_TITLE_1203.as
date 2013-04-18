package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_SET_CUR_TITLE_1203 extends MsgBase
	{
		public var title_id:uint;
		
		public function MSG_RES_SET_CUR_TITLE_1203(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			title_id = input.readUnsignedInt();			
		}
	}
}