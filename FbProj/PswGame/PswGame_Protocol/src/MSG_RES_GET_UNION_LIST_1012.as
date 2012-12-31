package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_UNION_LIST_1012 extends MsgBase
	{
		public var union_list:Vector.<uid_role_t>;
		
		public function MSG_RES_GET_UNION_LIST_1012(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var union_listLen:uint =input.readUnsignedInt();
			union_list= new Vector.<uid_role_t>();
			for(var i:int=0;i<union_listLen;++i)
			{
				var item:uid_role_t = new uid_role_t()
				item.readExternal(input);;
				union_list.push(item);
			}			
		}
	}
}