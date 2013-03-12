package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WALK_1028 extends MsgBase
	{
		public var timestamp:uint;
		public var type:uint;
		public var postions:Vector.<map_pos_t>;
		
		public function MSG_REQ_WALK_1028()
		{
			super(1028)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(timestamp);
			output.writeByte(type);
			output.writeUnsignedInt(postions.length);
			for(var i:int=0;i<postions.length;++i)
			{
				postions[i].writeExternal(output);
			}			
		}
	}
}