package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WALK_1028 extends MsgBase
	{
		public var timestamp:uint;
		public var user_id:uint;
		public var type:uint;
		public var postions:Vector.<map_pos_t>;
		
		public function MSG_RES_WALK_1028(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			timestamp = input.readUnsignedInt();
			user_id = input.readUnsignedInt();
			type = input.readUnsignedByte();
			var postionsLen:uint =input.readUnsignedInt();
			postions= new Vector.<map_pos_t>();
			for(var i:int=0;i<postionsLen;++i)
			{
				var postions_item:map_pos_t = new map_pos_t()
				postions_item.readExternal(input);;
				postions.push(postions_item);
			}			
		}
	}
}