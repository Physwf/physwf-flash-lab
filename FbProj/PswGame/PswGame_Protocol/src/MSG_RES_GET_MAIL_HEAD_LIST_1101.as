package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_MAIL_HEAD_LIST_1101 extends MsgBase
	{
		public var mails:Vector.<mail_head_t>;
		
		public function MSG_RES_GET_MAIL_HEAD_LIST_1101(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var mailsLen:uint =input.readUnsignedInt();
			mails= new Vector.<mail_head_t>();
			for(var i:int=0;i<mailsLen;++i)
			{
				var mails_item:mail_head_t = new mail_head_t()
				mails_item.readExternal(input);;
				mails.push(mails_item);
			}			
		}
	}
}