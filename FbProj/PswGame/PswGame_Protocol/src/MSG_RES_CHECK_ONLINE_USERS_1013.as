package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_CHECK_ONLINE_USERS_1013 extends MsgBase
	{
		public var online_list:Vector.<uid_role_t>;
		
		public function MSG_RES_CHECK_ONLINE_USERS_1013(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var online_listLen:uint =input.readUnsignedInt();
			online_list= new Vector.<uid_role_t>();
			for(var i:int=0;i<online_listLen;++i)
			{
				var online_list_item:uid_role_t = new uid_role_t()
				online_list_item.readExternal(input);;
				online_list.push(online_list_item);
			}			
		}
	}
}