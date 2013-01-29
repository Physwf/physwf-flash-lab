package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_UNION_LIST_1079 extends MsgBase
	{
		public var union_list:Vector.<uid_role_t>;
		
		public function MSG_RES_GET_UNION_LIST_1079(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var union_listLen:uint =input.readUnsignedInt();
			union_list= new Vector.<uid_role_t>();
			for(var i:int=0;i<union_listLen;++i)
			{
				var union_list_item:uid_role_t = new uid_role_t()
				union_list_item.readExternal(input);;
				union_list.push(union_list_item);
			}			
		}
	}
}