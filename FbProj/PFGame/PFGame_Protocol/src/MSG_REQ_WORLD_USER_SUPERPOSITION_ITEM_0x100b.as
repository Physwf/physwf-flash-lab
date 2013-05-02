package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_SUPERPOSITION_ITEM_0x100b extends MsgBase
	{
		public var item_superposition_pos:Vector.<db_swap_pos_t>;
		
		public function MSG_REQ_WORLD_USER_SUPERPOSITION_ITEM_0x100b()
		{
			super(0x100b)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(item_superposition_pos.length);
			for(var i:uint=0;i<item_superposition_pos.length;i++)
			{
				item_superposition_pos[i].writeExternal(output);
			}			
		}
	}
}