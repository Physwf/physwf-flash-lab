package com.physwf.system.vo
{
	/**
	 * 道具基类 
	 * @author joe
	 * 
	 */	
	public class ItemInfo
	{
		/**
		 *道具id 
		 */		
		public var itemID:uint;
		/**
		 *资源id 
		 */		
		public var resID:uint;
		/**
		 *名称 
		 */		
		public var name:String;
		/**
		 *描述 
		 */		
		public var details:String;
		/**
		 *种类 
		 */		
		public var category:uint;
		/**
		 *售价 
		 */		
		public var sellPrice:uint;
		/**
		 *买入价 
		 */		
		public var buyPrice:uint;
		/**
		 *维修价 
		 */		
		public var repairPrice:uint;
		/**
		 *耐久度 
		 */		
		public var durability:uint;
		/**
		 *最大拥有数量 
		 */		
		public var maxNum:uint;
		/**
		 *使用等级 
		 */		
		public var useLevel:uint;
		/**
		 *是否可堆叠 
		 */		
		public var accumulate:uint;
		/**
		 *是否可交易 
		 */		
		public var tradable:uint;
		/**
		 *vip是否可交易 
		 */		
		public var vipTradable:uint;
		/**
		 *是否可销毁 
		 */		
		public var destroyable:uint;
		/**
		 *是否可放入仓库 
		 */		
		public var storable:uint;
		/**
		 *是否可以打孔 
		 */		
		public var slot:uint;
		/**
		 *有效时间长 
		 */		
		public var durationTime:uint;
		/**
		 *有效时间点 
		 */		
		public var endTime:uint;
		/**
		 *功能 
		 */		
		public var functionID:uint;
		/**
		 *功能数据 
		 */		
		public var functionNum:uint;
	}
}