package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_DEL_EQUIP_1092 extends MsgBase
	{
		public var grid:uint;
		public var instance_id:uint;
		
		public function MSG_REQ_DEL_EQUIP_1092()
		{
			super(1092)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(grid);
			output.writeUnsignedInt(instance_id);			
		}
	}
}