package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_RECENTLY_CONTACTED_LIST_1081 extends MsgBase
	{
		public var user_list:Vector.<recent_friend_t>;
		
		public function MSG_RES_GET_RECENTLY_CONTACTED_LIST_1081(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var user_listLen:uint =input.readUnsignedInt();
			user_list= new Vector.<recent_friend_t>();
			for(var i:int=0;i<user_listLen;++i)
			{
				var user_list_item:recent_friend_t = new recent_friend_t()
				user_list_item.readExternal(input);;
				user_list.push(user_list_item);
			}			
		}
	}
}