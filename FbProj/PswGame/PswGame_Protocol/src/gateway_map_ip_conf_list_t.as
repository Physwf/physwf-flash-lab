package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class gateway_map_ip_conf_list_t implements IExternalizable
	{
		public var map:Vector.<gateway_map_ip_conf_t>;
		
		public function gateway_map_ip_conf_list_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var mapLen:uint =input.readUnsignedInt();
			map= new Vector.<gateway_map_ip_conf_t>();
			for(var i:int=0;i<mapLen;++i)
			{
				var map_item:gateway_map_ip_conf_t = new gateway_map_ip_conf_t()
				map_item.readExternal(input);;
				map.push(map_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(map.length);
			for(var i:int=0;i<map.length;++i)
			{
				map[i].writeExternal(output);
			}			
		}
	}
}