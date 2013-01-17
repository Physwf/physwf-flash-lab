package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_maps_t implements IExternalizable
	{
		public var Map:Vector.<xml_maps_item_t>;
		
		public function xml_maps_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var MapLen:uint =input.readUnsignedInt();
			Map= new Vector.<xml_maps_item_t>();
			for(var i:int=0;i<MapLen;++i)
			{
				var Map_item:xml_maps_item_t = new xml_maps_item_t()
				Map_item.readExternal(input);;
				Map.push(Map_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(Map.length);
			for(var i:int=0;i<Map.length;++i)
			{
				Map[i].writeExternal(output);
			}			
		}
	}
}