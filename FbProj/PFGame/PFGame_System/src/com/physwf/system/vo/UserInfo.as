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
		
		public function UserInfo()
		{
		}
	}
}