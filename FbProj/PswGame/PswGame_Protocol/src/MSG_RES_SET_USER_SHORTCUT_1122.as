package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_SET_USER_SHORTCUT_1122 extends MsgBase
	{
		public var shortcut:stru_shortcut_t;
		
		public function MSG_RES_SET_USER_SHORTCUT_1122(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			shortcut= new stru_shortcut_t();
			shortcut.readExternal(input)			
		}
	}
}