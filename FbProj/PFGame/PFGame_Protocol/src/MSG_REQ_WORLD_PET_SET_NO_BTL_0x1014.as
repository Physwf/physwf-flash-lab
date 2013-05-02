package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_PET_SET_NO_BTL_0x1014 extends MsgBase
	{
		public var key:uint;
		
		public function MSG_REQ_WORLD_PET_SET_NO_BTL_0x1014()
		{
			super(0x1014)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(key);			
		}
	}
}