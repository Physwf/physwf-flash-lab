package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_UPDATE_PET_SKILL_0x101f extends MsgBase
	{
		public var pet_key:uint;
		public var skills:Vector.<uint>;
		
		public function MSG_REQ_WORLD_UPDATE_PET_SKILL_0x101f()
		{
			super(0x101f)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(pet_key);
			output.writeUnsignedInt(skills.length);
			for(var i:uint=0;i<skills.length;i++)
			{
				output.writeUnsignedInt(skills[i]);
			}			
		}
	}
}