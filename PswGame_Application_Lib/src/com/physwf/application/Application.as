package com.physwf.application 
{
	import com.physwf.application.events.DriverEvent;
	import com.physwf.application.events.ScriptEvent;
	import com.physwf.application.plugin.IPlugin;
	import com.physwf.application.plugin.PluginEvent;
	import com.physwf.application.plugin.PluginInfo;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	/**
	 * Application用来调度，驱动系统的运行。其生命周期为整个系统的周期。
	 * @author joe
	 * 
	 */	
	public class Application
	{
		public static const APPLICATION_SYSTEM:int = 0;
		public static const APPLICATION_GMAE:int = 1;
		public static const APPLICATION_MAP:int = 2;
		
		public static var application:Application;
		
		private var mSandBox:SandBox;
		private var mDriver:Driver;
		private var mRoot:Sprite;
		
		private var mPlugins:Dictionary;
		
		[Embed(source="assets/system.swf",symbol="McApplicationLoading")]
		private var LoadingBar:Class;
		
		private var mLoadingBar:DisplayObject;
		
		public function Application(root:Sprite)
		{
			if(application) throw "Application为单例！";
			mSandBox = new SandBox();
			mDriver = new Driver(mSandBox);
			mRoot = root;
			mPlugins = new Dictionary();
			
			mLoadingBar = new LoadingBar() as DisplayObject;
			mLoadingBar.x = root.stage.stageWidth * .5;
			mLoadingBar.y = root.stage.stageHeight * .5;
			root.addChild(mLoadingBar);
			
			application = this;
		}
		
		public function startup():void
		{
			mDriver.addEventListener(ScriptEvent.SCRIPT_LOADED,onScriptLoaded);
			mDriver.loadScript("script/startup.xml",Driver.SCRIPT_XML);
		}
		
		private function onScriptLoaded(e:ScriptEvent):void
		{
			mDriver.addEventListener(DriverEvent.DRIVER_AVALIABLE,onDriverAvaliable);
			mDriver.addEventListener(DriverEvent.DRIVER_PROGRESS,onDriverProgress);
			mDriver.start();
		}
		
		private function onDriverAvaliable(e:Event):void
		{
			loadNext();
		}
		
		private function loadNext():void
		{
			if(mDriver.nextLoadItem) install(mDriver.nextLoadItem)
		}
		
		private function onDriverProgress(e:DriverEvent):void
		{
			progress = Number(e.data);
		}
		
		public function registerPlugin(key:PluginInfo,plugin:IPlugin):void
		{
			plugin.addEventListener(PluginEvent.PLUGIN_FINISHED,onPluginFinished);
			mPlugins[key] = plugin;
		}
		
		private function onPluginFinished(e:PluginEvent):void
		{
			var pluginInfo:PluginInfo = e.pluginInfo;
			var plugin:IPlugin = mPlugins[e.pluginInfo] as IPlugin;
			if(!plugin) throw "该插件并未安装！";
			plugin.dispose();
			delete mPlugins[pluginInfo];
			
			if(pluginInfo.domain.useSub)
			{
				mSandBox.destroySubDomain(pluginInfo.domain.name);
			}
		}
		
		public function restart():void
		{
			mSandBox.clear();
			mDriver = new Driver(mSandBox);
			startup();
		}
		
		public function exit():void
		{
			mDriver.dispose();
			mDriver = null;
			mSandBox.clear();
		}
		/**
		 * 安装插件
		 * @param pluginInfo
		 * 
		 */
		public function install(pluginInfo:PluginInfo):void
		{
			var domain:ApplicationDomain;
			if(pluginInfo.domain.useSub)
			{
				domain = mSandBox.getSubDomain(pluginInfo.domain.name);
				if(!domain)
					domain = mSandBox.registerSubDomian(pluginInfo.domain.name,pluginInfo.domain.level);
			} 
			else
			switch(pluginInfo.domain.level)
			{
				case APPLICATION_SYSTEM:
					domain = mSandBox.systemDomain;
					break;
				case APPLICATION_GMAE:
					domain = mSandBox.gameDomain;
					break;
				case APPLICATION_MAP:
					domain = mSandBox.curMapDomain;
					break;
			}
			mDriver.load(pluginInfo,domain);
		}
		/**
		 * 卸载插件 
		 * @param pluginInfo
		 */		
		public function uninstall(pluginInfo:PluginInfo):void
		{
			var index:int = mPlugins.indexOf(pluginInfo);
			if(index<0) throw "该插件并未安装！";
			mPlugins.splice(index,1);
			
			if(pluginInfo.domain.useSub)
			{
				mSandBox.destroySubDomain(pluginInfo.domain.name);
			}
		}
		
		public function set progress(v:Number):void
		{
			mLoadingBar["txtPercent"]["text"] = int(v*100)+"%";
			mLoadingBar["mcBar"].scaleX = v;
			if(v>=1) mRoot.removeChild(mLoadingBar);
		}
		
		public function get sandBox():SandBox
		{
			return mSandBox;
		}
		
		public function get driver():Driver
		{
			return mDriver;
		}
		
		public function get root():Sprite
		{
			return mRoot;
		}
	}
}