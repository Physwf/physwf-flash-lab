package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_CHECK_ONLINE_USERS_1013 extends MsgBase
	{
		public var id_list:Vector.<uid_role_t>;
		
		public function MSG_REQ_CHECK_ONLINE_USERS_1013()
		{
			super(1013)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(id_list.length);
			for(var i:int=0;i<id_list.length;++i)
			{
				id_list[i].writeExternal(output);
			}			
		}
	}
}