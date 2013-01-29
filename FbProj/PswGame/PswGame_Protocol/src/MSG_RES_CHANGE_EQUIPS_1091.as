package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_CHANGE_EQUIPS_1091 extends MsgBase
	{
		public var equips:Vector.<stru_equip_simple_t>;
		
		public function MSG_RES_CHANGE_EQUIPS_1091(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			equips= new Vector.<stru_equip_simple_t>();
			for(var i:int=0;i<16;++i)
			{
				var equips_item:stru_equip_simple_t = new stru_equip_simple_t()
				equips_item.readExternal(input);
				equips.push(equips_item)
			}
			
		}
	}
}