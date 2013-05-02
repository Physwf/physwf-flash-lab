package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_NOTIFY_ADD_EVENTS_0x131a extends MsgBase
	{
		public var events:Vector.<db_event_t>;
		
		public function MSG_RES_WORLD_NOTIFY_ADD_EVENTS_0x131a(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var eventsLen:uint =input.readUnsignedInt();
			events= new Vector.<db_event_t>();
			for(var i:uint=0;i<eventsLen;i++)
			{
				var events_item:db_event_t = new db_event_t()
				events_item.readExternal(input);;
				events.push(events_item);
			}			
		}
	}
}