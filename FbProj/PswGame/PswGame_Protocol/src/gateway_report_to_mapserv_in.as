package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class gateway_report_to_mapserv_in implements IExternalizable
	{
		public var area_id:uint;
		
		public function gateway_report_to_mapserv_in()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			area_id = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(area_id);			
		}
	}
}