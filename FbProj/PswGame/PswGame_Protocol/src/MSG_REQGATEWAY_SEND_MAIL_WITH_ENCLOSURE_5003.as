package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQGATEWAY_SEND_MAIL_WITH_ENCLOSURE_5003 extends MsgBase
	{
		public var recvers:Vector.<uid_role_t>;
		public var mail_title:String;
		public var mail_title_data:ByteArray
		public var mail_content:msg_t;
		public var items:Vector.<bag_item_t>;
		
		public function MSG_REQGATEWAY_SEND_MAIL_WITH_ENCLOSURE_5003()
		{
			super(5003)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(recvers.length);
			for(var i:int=0;i<recvers.length;++i)
			{
				recvers[i].writeExternal(output);
			}
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
			for(var j:int=0;j<items.length;++j)
			{
				items[j].writeExternal(output);
			}			
		}
	}
}