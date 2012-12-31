package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_MAP_PLAYER_MOVE_1036 extends MsgBase
	{
		public var x:uint;
		public var y:uint;
		public var dir:uint;
		
		public function MSG_REQ_MAP_PLAYER_MOVE_1036()
		{
			super(1036)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeInt(x);
			output.writeInt(y);
			output.writeInt(dir);			
		}
	}
}