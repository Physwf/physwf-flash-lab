package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class line_info_t implements IExternalizable
	{
		public var line_index:uint;
		public var line_players_count:uint;
		
		public function line_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			line_index = input.readUnsignedInt();
			line_players_count = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(line_index);
			output.writeInt(line_players_count);			
		}
	}
}