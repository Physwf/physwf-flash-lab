package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_ADORE_SUBMIT_1201 extends MsgBase
	{
		public var adored_user_id:uint;
		public var adored_role_tm:uint;
		public var adored_times:uint;
		
		public function MSG_REQ_ADORE_SUBMIT_1201()
		{
			super(1201)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(adored_user_id);
			output.writeUnsignedInt(adored_role_tm);
			output.writeUnsignedInt(adored_times);			
		}
	}
}