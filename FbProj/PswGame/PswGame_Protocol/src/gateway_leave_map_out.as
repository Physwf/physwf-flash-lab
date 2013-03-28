package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class gateway_leave_map_out implements IExternalizable
	{
		public var sprite_data:stru_sprite_t;
		
		public function gateway_leave_map_out()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			sprite_data= new stru_sprite_t();
			sprite_data.readExternal(input)			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			sprite_data.writeExternal(output)			
		}
	}
}