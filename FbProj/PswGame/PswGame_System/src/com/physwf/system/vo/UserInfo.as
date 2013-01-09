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
		public var prof:String;//profession
		/**
		 *等级 
		 */		
		public var level:uint;
		/**
		 *经验 
		 */		
		public var exp:uint;
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
		 *裸模id 
		 */		
		public var resource_id:uint;
		/**
		 *力量 
		 */		
		public var strength:uint;
		/**
		 *灵气 
		 */		
		public var intelligence:uint;
		/**
		 *体力 
		 */		
		public var physical:uint;
		/**
		 *魔力 
		 */		
		public var magic:uint;
		/**
		 *灵巧 
		 */		
		public var speed:uint;
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
		 *魔法攻击 
		 */		
		public var mattack:uint;
		/**
		 *物理防御 
		 */		
		public var defense:uint;
		/**
		 *魔法防御 
		 */		
		public var mdefence:uint;
		/**
		 *命中 
		 */		
		public var hit:uint;
		/**
		 *闪避 
		 */		
		public var avoid:uint;
		/**
		 *暴击 
		 */		
		public var multiattack:uint;
		/**
		 *暴击闪避 
		 */		
		public var multiavoid:uint;
		/**
		 * 装备信息 
		 */		
		public var equips:Vector.<EquipInfo> = new <EquipInfo>[];
		
		public function UserInfo()
		{
		}
	}
}