package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_PET_CHANGE_NAME_0x1011 extends MsgBase
	{
		public var key:uint;
		
		public function MSG_RES_WORLD_PET_CHANGE_NAME_0x1011(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			key = input.readUnsignedInt();			
		}
	}
}