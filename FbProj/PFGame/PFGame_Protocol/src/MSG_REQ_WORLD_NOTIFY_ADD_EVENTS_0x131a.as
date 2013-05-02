package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_NOTIFY_ADD_EVENTS_0x131a extends MsgBase
	{
		public var events:Vector.<db_event_t>;
		
		public function MSG_REQ_WORLD_NOTIFY_ADD_EVENTS_0x131a()
		{
			super(0x131a)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(events.length);
			for(var i:uint=0;i<events.length;i++)
			{
				events[i].writeExternal(output);
			}			
		}
	}
}