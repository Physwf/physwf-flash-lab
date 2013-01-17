package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class gateway_map_ip_conf_t implements IExternalizable
	{
		public var id:uint;
		public var ip_port:String;
		public var ip_port_data:ByteArray
		
		public function gateway_map_ip_conf_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			var ip_portLen:uint =input.readUnsignedInt();
			ip_port=input.readUTFBytes(ip_portLen);			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(id);
			output.writeUnsignedInt(ip_port.length);
			output.writeUTFBytes(ip_port);			
		}
	}
}