package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SEND_MAIL_1105 extends MsgBase
	{
		public var recv_id:uint;
		public var recv_role_tm:uint;
		public var mail_title:String;
		public var mail_title_data:ByteArray
		public var mail_content:msg_t;
		public var items:Vector.<bag_item_t>;
		
		public function MSG_REQ_SEND_MAIL_1105()
		{
			super(1105)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(recv_id);
			output.writeUnsignedInt(recv_role_tm);
			if(mail_title_data)
			{
				output.writeBytes(mail_title_data)
			}
			else
			{
				var mail_titleData:ByteArray = new ByteArray();
				mail_titleData.writeUTFBytes(mail_title)
				mail_titleData.length = 50;
				output.writeBytes(mail_titleData)
			}
			mail_content.writeExternal(output)
			output.writeUnsignedInt(items.length);
			for(var i:int=0;i<items.length;++i)
			{
				items[i].writeExternal(output);
			}			
		}
	}
}