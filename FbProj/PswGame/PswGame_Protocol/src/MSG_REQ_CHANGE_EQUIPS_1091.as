package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_CHANGE_EQUIPS_1091 extends MsgBase
	{
		public var equips:Vector.<exchange_grid_t>;
		
		public function MSG_REQ_CHANGE_EQUIPS_1091()
		{
			super(1091)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(equips.length);
			for(var i:int=0;i<equips.length;++i)
			{
				equips[i].writeExternal(output);
			}			
		}
	}
}