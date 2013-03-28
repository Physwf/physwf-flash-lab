package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_ADJUST_1058 extends MsgBase
	{
		public var grids:Vector.<bag_item_t>;
		
		public function MSG_REQ_ADJUST_1058()
		{
			super(1058)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(grids.length);
			for(var i:int=0;i<grids.length;++i)
			{
				grids[i].writeExternal(output);
			}			
		}
	}
}