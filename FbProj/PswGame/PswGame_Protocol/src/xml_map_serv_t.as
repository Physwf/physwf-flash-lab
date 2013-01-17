package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_map_serv_t implements IExternalizable
	{
		public var Server:Vector.<xml_map_serv_item_t>;
		
		public function xml_map_serv_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var ServerLen:uint =input.readUnsignedInt();
			Server= new Vector.<xml_map_serv_item_t>();
			for(var i:int=0;i<ServerLen;++i)
			{
				var Server_item:xml_map_serv_item_t = new xml_map_serv_item_t()
				Server_item.readExternal(input);;
				Server.push(Server_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(Server.length);
			for(var i:int=0;i<Server.length;++i)
			{
				Server[i].writeExternal(output);
			}			
		}
	}
}