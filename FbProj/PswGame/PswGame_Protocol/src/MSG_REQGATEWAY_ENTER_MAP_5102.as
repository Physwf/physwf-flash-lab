package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQGATEWAY_ENTER_MAP_5102 extends MsgBase
	{
		public var map_id:uint;
		public var map_x:uint;
		public var map_y:uint;
		public var sprite_data:Vector.<stru_sprite_t>;
		
		public function MSG_REQGATEWAY_ENTER_MAP_5102()
		{
			super(5102)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(map_id);
			output.writeUnsignedInt(map_x);
			output.writeUnsignedInt(map_y);
			output.writeUnsignedInt(sprite_data.length);
			for(var i:int=0;i<sprite_data.length;++i)
			{
				sprite_data[i].writeExternal(output);
			}			
		}
	}
}