package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_ADD_SKILL_1120 extends MsgBase
	{
		public var skill:stru_skill_t;
		
		public function MSG_RES_ADD_SKILL_1120(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			skill= new stru_skill_t();
			skill.readExternal(input)			
		}
	}
}