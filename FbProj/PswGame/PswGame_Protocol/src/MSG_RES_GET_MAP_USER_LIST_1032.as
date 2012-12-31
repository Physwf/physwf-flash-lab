package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_MAP_USER_LIST_1032 extends MsgBase
	{
		public var user_infos:Vector.<map_user_info>;
		
		public function MSG_RES_GET_MAP_USER_LIST_1032(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var user_infosLen:uint =input.readUnsignedInt();
			user_infos= new Vector.<map_user_info>();
			for(var i:int=0;i<user_infosLen;++i)
			{
				var item:map_user_info = new map_user_info()
				item.readExternal(input);;
				user_infos.push(item);
			}			
		}
	}
}