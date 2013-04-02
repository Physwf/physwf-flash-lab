package com.physwf.system.vo
{
	public class UserInfo
	{
		/**
		 * 用户id 
		 */		
		public var uid:uint;
		/**
		 * 创建时间
		 */		
		public var createTime:uint;
		/**
		 *昵称 
		 */		
		public var nick:String;
		/**
		 *职业 
		 */		
		public var prof:uint;//profession
		/**
		 *等级 
		 */		
		public var level:uint;
		/**
		 * 性别 
		 */		
		public var sex:uint;
		/**
		 *经验 
		 */		
		public var exp:uint;
		/**
		 *金钱 
		 */		
		public var money:uint;
		/**
		 *当前所在的地图ID 
		 */		
		public var map_id:uint;
		/**
		 *当前所在地图位置的x坐标 
		 */		
		public var map_x:uint;
		/**
		 *当前所在地图 的y坐标
		 */		
		public var map_y:uint;
		/**
		 * 将要移动到的目标点 
		 */		
		public var target_x:uint;
		/**
		 * 将要移动到的目标点 
		 */		
		public var target_y:uint;
		/**
		 * 移动路径 
		 */		
		public var path:Vector.<uint>;
		/**
		 *裸模id 
		 */		
		public var resource_id:uint;
		/**
		 *力量 
		 */		
		public var strength:uint;
		/**
		 *属性点灵力
		 */		
		public var magic:uint;
		/**
		 *属性点体力
		 */		
		public var physical:uint;
		/**
		 *属性点魔力 
		 */		
		public var spell:uint;
		/**
		 *属性点心智 
		 */		
		public var mind:uint;
		/**
		 *额外点数 
		 */		
		public var additions:uint;
		/**
		 *生命值 
		 */		
		public var hp:uint;
		/**
		 *魔法值 
		 */		
		public var mp:uint;
		/**
		 *精力 
		 */		
		public var energy:uint;
		/**
		 *最大生命值 
		 */		
		public var hp_max:uint;
		/**
		 *最大魔法值 
		 */		
		public var mp_max:uint;
		/**
		 *物理攻击 
		 */		
		public var attack:uint;
		/**
		 *物理防御 
		 */		
		public var defense:uint;
		/**
		 *魔法攻击 
		 */		
		public var mattack:uint;
		/**
		 *魔法防御 
		 */		
		public var mdefence:uint;
		/**
		 *增加会心攻击 
		 */		
		public var critAtk:uint;
		/**
		 *增加会心闪避 
		 */		
		public var critDef:uint;
		/**
		 *命中 
		 */		
		public var hit:uint;
		/**
		 *闪避 
		 */		
		public var dodge:uint;
		/**
		 *地属性攻击 
		 */
		public var earthAtk:uint;
		public var earthDef:uint;
		/**
		 *水属性攻击 
		 */		
		public var waterAtk:uint;
		public var waterDef:uint;
		/**
		 *风属性攻击 
		 */		
		public var windAtk:uint;
		public var windDef:uint;
		/**
		 *火属性攻击 
		 */		
		public var fireAtk:uint;
		public var fireDef:uint;
		/**
		 * 装备信息 
		 */		
		public var equips:Vector.<EquipInfo> = new <EquipInfo>[];
		
		public function UserInfo()
		{
		}
	}
}