package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_REQ_RM_MSGS_0x1312 extends MsgBase
	{
		public var sns:Vector.<uint>;
		
		public function MSG_RES_WORLD_USER_REQ_RM_MSGS_0x1312(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var snsLen:uint =input.readUnsignedInt();
			sns= new Vector.<uint>();
			for(var i:uint=0;i<snsLen;i++)
			{
				var sns_item:uint = input.readUnsignedInt();;
				sns.push(sns_item);
			}			
		}
	}
}