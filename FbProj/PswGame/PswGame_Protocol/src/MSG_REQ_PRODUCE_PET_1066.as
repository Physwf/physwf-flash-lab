package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_PRODUCE_PET_1066 extends MsgBase
	{
		public var grid:uint;
		
		public function MSG_REQ_PRODUCE_PET_1066()
		{
			super(1066)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(grid);			
		}
	}
}