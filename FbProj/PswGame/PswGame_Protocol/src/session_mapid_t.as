package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class session_mapid_t implements IExternalizable
	{
		public var mapid:uint;
		
		public function session_mapid_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			mapid = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(mapid);			
		}
	}
}