package com.physwf.config
{
	import com.physwf.config.struct.cfg_monster;
	import com.physwf.config.struct.cfg_player;
	import com.physwf.config.struct.cfg_skill;
	import com.physwf.system.vo.MonsterInfo;
	import com.physwf.system.vo.SkillInfo;
	import com.physwf.system.vo.UserInfo;

	/**
	 * 配置读取。
	 * 服务端值保存变化的字段值，静态的字段保存在客户端配置中，并通过关键字段来读取。
	 * @author joe
	 * 
	 */
	public class ConfigReader
	{
		public function ConfigReader()
		{
		}
		/**
		 * 读取怪物配置信息 
		 * @param info
		 * @return 
		 * 
		 */		
		public static function readMonster(info:MonsterInfo):MonsterInfo
		{
			var cfg:cfg_monster = Config.getMonsterConfig(info.id);
			if(cfg == null) throw "怪物配表有问题！";
			info.hp_max = cfg.hp_max;
			return info;
		}
		
		public static function readSkill(info:SkillInfo):void
		{
			var cfg:cfg_skill = Config.getSkillConfig(info.id);
			if(cfg == null) throw "技能配表有问题！";
			info.range = cfg.atk_distance;
		}
		
		public static function readPlayer(info:UserInfo):void
		{
			var cfg:cfg_player = Config.getPlayerConfig(info.prof,info.level);
			if(cfg == null) throw "用户配表有问题！";
		}
	}
}