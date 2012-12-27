package com.physwf.application 
{
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	/**
	 * 沙箱用来管理应用程序域。
	 * @author joe
	 * 
	 */	
	public class SandBox
	{
		public static const DOMAIN_SYSTEM:int = 0;
		public static const DOMAIN_GAME:int = 1;
		public static const DOMAIN_MAP:int = 2;
		
		private var mSystemDomain:ApplicationDomain;
		private var mGameDomain:ApplicationDomain;
		private var mCurMapDomain:ApplicationDomain;
		private var mSystemSubDomain:Vector.<ApplicationDomain>;
		// 属于以上三个域的子域，这些子域之下的子域应该由相应模块来管理，系统不参与细节。
		private var subDomains:Dictionary;
		
		public function SandBox()
		{
			buildDomain();
		}
		
		private function buildDomain():void
		{
			//初始化 应用程序域
			//系统域为最高等级域，游戏域为其子域，地图域为游戏域的子域
			//系统域及游戏域在系统初始化之后简历。地图域与地图的初始化与销毁相关联
			mSystemDomain = ApplicationDomain.currentDomain;
			mGameDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
			mCurMapDomain = new ApplicationDomain(mGameDomain);
			subDomains = new Dictionary();
		}
		/**
		 * 系统域 
		 * @return 
		 * 
		 */		
		public function get systemDomain():ApplicationDomain
		{
			return mSystemDomain;
		}
		/**
		 * 注册子域
		 * @param name 域名称
		 * @param type 域类型，指定是该子域隶属于哪一个域，该参数可能值为：
		 * SandBox::DOMAIN_SYSTEM,SandBox::DOMAIN_GAME,SandBox::DOMAIN_MAP。
		 */
		public function registerSubDomian(name:String,level:int):ApplicationDomain
		{
			var parent:ApplicationDomain;
			switch(level)
			{
				case DOMAIN_SYSTEM:
				{
					parent = mSystemDomain;
					break;
				}
				case DOMAIN_GAME:
				{
					parent = mGameDomain;
					break;
				}
				case DOMAIN_MAP:
				{
					parent = mCurMapDomain;
					break;
				}
			}
			if(subDomains[name]) throw "该名称已经被注册！";
			subDomains[name] = new ApplicationDomain(parent);
			return subDomains[name];
		}
		/**
		 * 根据名称获取域 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getSubDomain(name:String):ApplicationDomain
		{
			if(!subDomains[name]) return null;
			return subDomains[name] as ApplicationDomain;
		}
		/**
		 * 销毁指定名称的域 
		 * @param name
		 * 
		 */		
		public function destroySubDomain(name:String):void
		{
			delete subDomains[name];
		}
		/**
		 * 游戏域 
		 * @return 
		 * 
		 */		
		public function get gameDomain():ApplicationDomain
		{
			return mGameDomain;
		}
		/**
		 * 重新建立地图域，改行为将导致之前的域销毁。
		 * 
		 */		
		public function rebuildMapDomain():void
		{
			mCurMapDomain = new ApplicationDomain(mGameDomain);
		}
		/**
		 * 当前地图域 
		 * @return 
		 * 
		 */		
		public function get curMapDomain():ApplicationDomain
		{
			return mCurMapDomain;
		}
		/**
		 * 清理沙箱 
		 * 
		 */		
		public function clear():void
		{
			buildDomain();
		}
	}
}