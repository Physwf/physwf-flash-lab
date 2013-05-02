package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_REQ_RM_MAILS_0x1316 extends MsgBase
	{
		public var sns:Vector.<uint>;
		
		public function MSG_REQ_WORLD_USER_REQ_RM_MAILS_0x1316()
		{
			super(0x1316)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(sns.length);
			for(var i:uint=0;i<sns.length;i++)
			{
				output.writeUnsignedInt(sns[i]);
			}			
		}
	}
}