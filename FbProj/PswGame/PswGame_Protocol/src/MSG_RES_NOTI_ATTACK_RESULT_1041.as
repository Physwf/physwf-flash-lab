package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_ATTACK_RESULT_1041 extends MsgBase
	{
		public var results:atk_result_t;
		
		public function MSG_RES_NOTI_ATTACK_RESULT_1041(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			results= new atk_result_t();
			results.readExternal(input)			
		}
	}
}