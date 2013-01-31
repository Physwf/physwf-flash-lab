package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_SET_PET_UNFOLLOW_1064 extends MsgBase
	{
		public var instance_id:uint;
		
		public function MSG_RES_SET_PET_UNFOLLOW_1064(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			instance_id = input.readUnsignedInt();			
		}
	}
}