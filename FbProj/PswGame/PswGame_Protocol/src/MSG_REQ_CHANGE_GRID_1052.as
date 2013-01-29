package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_CHANGE_GRID_1052 extends MsgBase
	{
		public var source_grid:uint;
		public var obj_grid:uint;
		
		public function MSG_REQ_CHANGE_GRID_1052()
		{
			super(1052)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(source_grid);
			output.writeShort(obj_grid);			
		}
	}
}