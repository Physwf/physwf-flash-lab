package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SET_USER_PROF_1202 extends MsgBase
	{
		public var prof:uint;
		
		public function MSG_REQ_SET_USER_PROF_1202()
		{
			super(1202)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeByte(prof);			
		}
	}
}