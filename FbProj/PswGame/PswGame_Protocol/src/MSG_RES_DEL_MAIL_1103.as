package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_DEL_MAIL_1103 extends MsgBase
	{
		public var mail_id:Vector.<uint>;
		
		public function MSG_RES_DEL_MAIL_1103(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var mail_idLen:uint =input.readUnsignedInt();
			mail_id= new Vector.<uint>();
			for(var i:int=0;i<mail_idLen;++i)
			{
				var mail_id_item:uint = input.readUnsignedInt();;
				mail_id.push(mail_id_item);
			}			
		}
	}
}