package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_PVE_0x1400 extends MsgBase
	{
		public var monsters_idx:uint;
		
		public function MSG_REQ_WORLD_USER_PVE_0x1400()
		{
			super(0x1400)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(monsters_idx);			
		}
	}
}