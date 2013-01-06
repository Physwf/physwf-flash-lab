package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_BLACKLIST_1011 extends MsgBase
	{
		public var blacklist:Vector.<uid_role_t>;
		
		public function MSG_RES_GET_BLACKLIST_1011(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var blacklistLen:uint =input.readUnsignedInt();
			blacklist= new Vector.<uid_role_t>();
			for(var i:int=0;i<blacklistLen;++i)
			{
				var item:uid_role_t = new uid_role_t()
				item.readExternal(input);;
				blacklist.push(item);
			}			
		}
	}
}