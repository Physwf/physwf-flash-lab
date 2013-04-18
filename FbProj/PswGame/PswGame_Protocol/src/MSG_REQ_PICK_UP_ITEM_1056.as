package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_PICK_UP_ITEM_1056 extends MsgBase
	{
		public var instance_id:uint;
		public var items:Vector.<uint>;
		
		public function MSG_REQ_PICK_UP_ITEM_1056()
		{
			super(1056)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(instance_id);
			output.writeUnsignedInt(items.length);
			for(var i:int=0;i<items.length;++i)
			{
				output.writeUnsignedInt(items[i]);
			}			
		}
	}
}