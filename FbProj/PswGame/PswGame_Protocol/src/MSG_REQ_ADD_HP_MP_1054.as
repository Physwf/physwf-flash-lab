package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_ADD_HP_MP_1054 extends MsgBase
	{
		public var grid:uint;
		
		public function MSG_REQ_ADD_HP_MP_1054()
		{
			super(1054)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(grid);			
		}
	}
}