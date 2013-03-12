package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_MONSTER_TALK_1044 extends MsgBase
	{
		public var monster_instance_id:uint;
		public var talkid:uint;
		
		public function MSG_RES_NOTI_MONSTER_TALK_1044(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			monster_instance_id = input.readUnsignedInt();
			talkid = input.readUnsignedInt();			
		}
	}
}