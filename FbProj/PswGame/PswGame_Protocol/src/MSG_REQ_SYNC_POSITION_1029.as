package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SYNC_POSITION_1029 extends MsgBase
	{
		public var timestamp:uint;
		public var type:uint;
		public var postion:map_pos_t;
		
		public function MSG_REQ_SYNC_POSITION_1029()
		{
			super(1029)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(timestamp);
			output.writeByte(type);
			postion.writeExternal(output)			
		}
	}
}