package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class gateway_enter_map_in implements IExternalizable
	{
		public var map_id:uint;
		public var map_x:uint;
		public var map_y:uint;
		public var sprite_data:Vector.<stru_sprite_t>;
		
		public function gateway_enter_map_in()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			map_id = input.readUnsignedInt();
			map_x = input.readUnsignedInt();
			map_y = input.readUnsignedInt();
			var sprite_dataLen:uint =input.readUnsignedInt();
			sprite_data= new Vector.<stru_sprite_t>();
			for(var i:int=0;i<sprite_dataLen;++i)
			{
				var sprite_data_item:stru_sprite_t = new stru_sprite_t()
				sprite_data_item.readExternal(input);;
				sprite_data.push(sprite_data_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(map_id);
			output.writeUnsignedInt(map_x);
			output.writeUnsignedInt(map_y);
			output.writeUnsignedInt(sprite_data.length);
			for(var j:int=0;j<sprite_data.length;++j)
			{
				sprite_data[j].writeExternal(output);
			}			
		}
	}
}