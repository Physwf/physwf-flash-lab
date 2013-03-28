package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_UPGRADE_SKILL_1121 extends MsgBase
	{
		public var skill:stru_skill_t;
		
		public function MSG_RES_UPGRADE_SKILL_1121(mid:uint)
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