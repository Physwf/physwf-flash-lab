package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class gateway_send_mail_with_enclosure_in implements IExternalizable
	{
		public var recvers:Vector.<uid_role_t>;
		public var mail_title:String;
		public var mail_title_data:ByteArray
		public var mail_content:msg_t;
		public var items:Vector.<bag_item_t>;
		
		public function gateway_send_mail_with_enclosure_in()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var recversLen:uint =input.readUnsignedInt();
			recvers= new Vector.<uid_role_t>();
			for(var i:int=0;i<recversLen;++i)
			{
				var recvers_item:uid_role_t = new uid_role_t()
				recvers_item.readExternal(input);;
				recvers.push(recvers_item);
			}
			mail_title = input.readUTFBytes(50);
			mail_content= new msg_t();
			mail_content.readExternal(input)
			var itemsLen:uint =input.readUnsignedInt();
			items= new Vector.<bag_item_t>();
			for(var k:int=0;k<itemsLen;++k)
			{
				var items_item:bag_item_t = new bag_item_t()
				items_item.readExternal(input);;
				items.push(items_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(recvers.length);
			for(var j:int=0;j<recvers.length;++j)
			{
				recvers[j].writeExternal(output);
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
			for(var p:int=0;p<items.length;++p)
			{
				items[p].writeExternal(output);
			}			
		}
	}
}