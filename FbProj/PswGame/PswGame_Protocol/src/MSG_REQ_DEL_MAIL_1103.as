package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_DEL_MAIL_1103 extends MsgBase
	{
		public var mail_id:Vector.<uint>;
		
		public function MSG_REQ_DEL_MAIL_1103()
		{
			super(1103)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(mail_id.length);
			for(var i:int=0;i<mail_id.length;++i)
			{
				output.writeUnsignedInt(mail_id[i]);
			}			
		}
	}
}