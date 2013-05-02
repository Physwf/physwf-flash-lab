package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_PET_UPDATE_EXP_DEF_SKILL_EXP_NOTIFY_0x1018 extends MsgBase
	{
		public var key:uint;
		public var exp:uint;
		public var def_skill_exp:uint;
		
		public function MSG_RES_WORLD_PET_UPDATE_EXP_DEF_SKILL_EXP_NOTIFY_0x1018(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			key = input.readUnsignedInt();
			exp = input.readUnsignedInt();
			def_skill_exp = input.readUnsignedInt();			
		}
	}
}