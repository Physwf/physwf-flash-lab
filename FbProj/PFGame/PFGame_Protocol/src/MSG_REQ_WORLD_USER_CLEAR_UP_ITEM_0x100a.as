package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_CLEAR_UP_ITEM_0x100a extends MsgBase
	{
		public var swap_pos:Vector.<db_swap_pos_t>;
		
		public function MSG_REQ_WORLD_USER_CLEAR_UP_ITEM_0x100a()
		{
			super(0x100a)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(swap_pos.length);
			for(var i:uint=0;i<swap_pos.length;i++)
			{
				swap_pos[i].writeExternal(output);
			}			
		}
	}
}