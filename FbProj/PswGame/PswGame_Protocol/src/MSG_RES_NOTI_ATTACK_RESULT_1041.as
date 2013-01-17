package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_ATTACK_RESULT_1041 extends MsgBase
	{
		public var results:Vector.<atk_result_t>;
		
		public function MSG_RES_NOTI_ATTACK_RESULT_1041(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var resultsLen:uint =input.readUnsignedInt();
			results= new Vector.<atk_result_t>();
			for(var i:int=0;i<resultsLen;++i)
			{
				var results_item:atk_result_t = new atk_result_t()
				results_item.readExternal(input);;
				results.push(results_item);
			}			
		}
	}
}