package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_DEL_PET_1062 extends MsgBase
	{
		public var instance_id:uint;
		
		public function MSG_RES_DEL_PET_1062(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			instance_id = input.readUnsignedInt();			
		}
	}
}