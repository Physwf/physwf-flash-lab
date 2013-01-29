package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_DEL_EQUIP_1092 extends MsgBase
	{
		public var grid:uint;
		public var instance_id:uint;
		public var equip_id:uint;
		
		public function MSG_RES_DEL_EQUIP_1092(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			grid = input.readUnsignedInt();
			instance_id = input.readUnsignedInt();
			equip_id = input.readUnsignedInt();			
		}
	}
}