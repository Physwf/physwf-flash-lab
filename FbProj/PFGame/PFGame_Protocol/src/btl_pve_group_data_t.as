package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class btl_pve_group_data_t implements IExternalizable
	{
		public var can_catch_num:uint;
		public var npc_escape_round:uint;
		
		public function btl_pve_group_data_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			can_catch_num = input.readUnsignedShort();
			npc_escape_round = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(can_catch_num);
			output.writeShort(npc_escape_round);			
		}
	}
}