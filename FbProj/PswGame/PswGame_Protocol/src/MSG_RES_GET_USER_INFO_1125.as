package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_USER_INFO_1125 extends MsgBase
	{
		public var rank_user_info:stru_rank_usr_t;
		
		public function MSG_RES_GET_USER_INFO_1125(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			rank_user_info= new stru_rank_usr_t();
			rank_user_info.readExternal(input)			
		}
	}
}