package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_REQ_FRIEND_SIMPLE_INFO_0x130c extends MsgBase
	{
		public var uids:Vector.<uint>;
		
		public function MSG_REQ_WORLD_USER_REQ_FRIEND_SIMPLE_INFO_0x130c()
		{
			super(0x130c)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uids.length);
			for(var i:uint=0;i<uids.length;i++)
			{
				output.writeUnsignedInt(uids[i]);
			}			
		}
	}
}