package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_RANKINGLIST_INFO_1124 extends MsgBase
	{
		public var ranking_type:uint;
		
		public function MSG_REQ_GET_RANKINGLIST_INFO_1124()
		{
			super(1124)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(ranking_type);			
		}
	}
}