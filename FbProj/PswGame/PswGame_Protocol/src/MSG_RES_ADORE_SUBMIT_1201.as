package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_ADORE_SUBMIT_1201 extends MsgBase
	{
		public var adored_user_id:uint;
		public var adored_role_tm:uint;
		public var used_times:uint;
		public var by_adore_times:uint;
		
		public function MSG_RES_ADORE_SUBMIT_1201(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			adored_user_id = input.readUnsignedInt();
			adored_role_tm = input.readUnsignedInt();
			used_times = input.readUnsignedInt();
			by_adore_times = input.readUnsignedInt();			
		}
	}
}