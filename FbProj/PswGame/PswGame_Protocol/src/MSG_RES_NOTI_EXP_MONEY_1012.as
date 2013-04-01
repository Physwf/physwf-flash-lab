package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_EXP_MONEY_1012 extends MsgBase
	{
		public var exp:uint;
		public var money:uint;
		
		public function MSG_RES_NOTI_EXP_MONEY_1012(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			exp = input.readUnsignedInt();
			money = input.readUnsignedInt();			
		}
	}
}