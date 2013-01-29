package com.physwf.system.vo
{
	public class EquipInfo extends ItemInfo
	{
		public var instanceID:uint;
		// 服务端的equipid字段 对应 itemID字段
		public var quality:uint;
		public var equipPos:uint;
		
		public var strength:uint;
		public var solar:uint;
		public var physique:uint;
		public var spirit:uint;
		public var agility:uint;
		
		public var atk:uint;
		public var magicAtk:uint;
		public var def:uint;
		public var magicDef:uint;
		public var crit:uint;//会心概率
		public var critDamage:uint;//会心攻击伤害倍率
		public var critTenacity:uint//会心韧性
		public var hit:uint;
		public var dodge:uint;
		
		public var earthAtk:uint;
		public var earthDef:uint;
		public var waterAtk:uint;
		public var waterDef:uint;
		public var fireAtk:uint;
		public var fireDef:uint;
		public var windAtk:uint;
		public var windDef:uint;
		
		public var postion:uint;//背包中位置
	}
}