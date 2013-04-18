package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_LOGIN_1001 extends MsgBase
	{
		public var user:stru_user_t;
		public var skills:Vector.<stru_skill_t>;
		public var skill_shortcut:Vector.<uint>;
		public var adore_times_per_day:uint;
		
		public function MSG_RES_LOGIN_1001(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user= new stru_user_t();
			user.readExternal(input)
			var skillsLen:uint =input.readUnsignedInt();
			skills= new Vector.<stru_skill_t>();
			for(var i:int=0;i<skillsLen;++i)
			{
				var skills_item:stru_skill_t = new stru_skill_t()
				skills_item.readExternal(input);;
				skills.push(skills_item);
			}
			skill_shortcut= new Vector.<uint>();
			for(var j:int=0;j<10;++j)
			{
				var skill_shortcut_item:uint = input.readUnsignedInt();
				skill_shortcut.push(skill_shortcut_item)
			}

			adore_times_per_day = input.readUnsignedInt();			
		}
	}
}