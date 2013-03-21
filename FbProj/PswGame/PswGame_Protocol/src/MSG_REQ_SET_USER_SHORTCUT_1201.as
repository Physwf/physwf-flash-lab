package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SET_USER_SHORTCUT_1201 extends MsgBase
	{
		public var shortcuts:Vector.<uint>;
		
		public function MSG_REQ_SET_USER_SHORTCUT_1201()
		{
			super(1201)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			for(var i:int=0;i<10;++i)
			{
				output.writeUnsignedInt(shortcuts[i])
			}
			
		}
	}
}