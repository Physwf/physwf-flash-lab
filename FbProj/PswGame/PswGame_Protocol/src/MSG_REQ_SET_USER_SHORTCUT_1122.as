package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SET_USER_SHORTCUT_1122 extends MsgBase
	{
		public var thing_id:uint;
		public var pos:uint;
		
		public function MSG_REQ_SET_USER_SHORTCUT_1122()
		{
			super(1122)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(thing_id);
			output.writeByte(pos);			
		}
	}
}