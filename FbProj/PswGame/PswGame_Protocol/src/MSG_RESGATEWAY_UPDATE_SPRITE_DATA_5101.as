package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RESGATEWAY_UPDATE_SPRITE_DATA_5101 extends MsgBase
	{
		public var sprite_data:stru_sprite_t;
		
		public function MSG_RESGATEWAY_UPDATE_SPRITE_DATA_5101(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			sprite_data= new stru_sprite_t();
			sprite_data.readExternal(input)			
		}
	}
}