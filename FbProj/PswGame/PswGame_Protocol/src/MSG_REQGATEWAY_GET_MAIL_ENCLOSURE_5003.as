package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQGATEWAY_GET_MAIL_ENCLOSURE_5003 extends MsgBase
	{
		public var items:Vector.<bag_item_t>;
		
		public function MSG_REQGATEWAY_GET_MAIL_ENCLOSURE_5003()
		{
			super(5003)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(items.length);
			for(var i:int=0;i<items.length;++i)
			{
				items[i].writeExternal(output);
			}			
		}
	}
}