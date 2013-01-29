package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_RECOMMENDED_FRIENDS_LIST_1074 extends MsgBase
	{
		public var user_list:Vector.<uid_role_t>;
		
		public function MSG_RES_GET_RECOMMENDED_FRIENDS_LIST_1074(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var user_listLen:uint =input.readUnsignedInt();
			user_list= new Vector.<uid_role_t>();
			for(var i:int=0;i<user_listLen;++i)
			{
				var user_list_item:uid_role_t = new uid_role_t()
				user_list_item.readExternal(input);;
				user_list.push(user_list_item);
			}			
		}
	}
}