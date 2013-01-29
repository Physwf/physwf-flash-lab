package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_USER_WALK_PATH_1029 extends MsgBase
	{
		public var postions:Vector.<map_pos_t>;
		
		public function MSG_REQ_USER_WALK_PATH_1029()
		{
			super(1029)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(postions.length);
			for(var i:int=0;i<postions.length;++i)
			{
				postions[i].writeExternal(output);
			}			
		}
	}
}