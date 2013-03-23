package com.physwf.engine.common.command
{
	import com.physwf.components.command.Command;
	import com.physwf.engine.world.objects.Character;
	/**
	 * 追击目标。在所选技能的攻击距离小于目标与自身之间的距离，且目标能够移动时，使用该命令。
	 * @author joe
	 * 
	 */	
	public class CmdFollowForAtk extends Command 
	{
		private var mChara:Character;
		private var mTarget:Character;
		
		public function CmdFollowForAtk(chara:Character)
		{
			mChara = chara;
		}
		
	}
}