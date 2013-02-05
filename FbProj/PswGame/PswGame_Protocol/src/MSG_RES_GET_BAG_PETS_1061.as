package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_BAG_PETS_1061 extends MsgBase
	{
		public var pets_grid:uint;
		public var pets:Vector.<stru_pet_bag_t>;
		
		public function MSG_RES_GET_BAG_PETS_1061(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			pets_grid = input.readUnsignedShort();
			var petsLen:uint =input.readUnsignedInt();
			pets= new Vector.<stru_pet_bag_t>();
			for(var i:int=0;i<petsLen;++i)
			{
				var pets_item:stru_pet_bag_t = new stru_pet_bag_t()
				pets_item.readExternal(input);;
				pets.push(pets_item);
			}			
		}
	}
}