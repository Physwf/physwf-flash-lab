package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_TITLE_LIST_1202 extends MsgBase
	{
		public var title_vec:Vector.<uint>;
		
		public function MSG_RES_GET_TITLE_LIST_1202(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var title_vecLen:uint =input.readUnsignedInt();
			title_vec= new Vector.<uint>();
			for(var i:int=0;i<title_vecLen;++i)
			{
				var title_vec_item:uint = input.readUnsignedInt();;
				title_vec.push(title_vec_item);
			}			
		}
	}
}