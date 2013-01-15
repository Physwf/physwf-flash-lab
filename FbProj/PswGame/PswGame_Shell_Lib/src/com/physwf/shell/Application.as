package com.physwf.shell 
{
	import com.physwf.shell.events.DriverEvent;
	import com.physwf.shell.events.ScriptEvent;
	import com.physwf.shell.plugin.IPlugin;
	import com.physwf.shell.plugin.PluginEvent;
	import com.physwf.shell.plugin.PluginInfo;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		
		private var mPluginQueue:Vector.<IPlugin>;
		private var mCurPlugin:IPlugin;
		private var mPluginsInRun:Vector.<IPlugin>;
		
		[Embed(source="assets/system.swf",symbol="McApplicationLoading")]
		private var LoadingBar:Class;
		
		[Embed(source="assets/system.swf",symbol="BtnSystem")]
		private var SystemBtn:Class;
		
		[Embed(source="assets/system.swf",symbol="McApplicationPower")]
		private var McApplicationPower:Class;
		
		private var mLoadingBar:DisplayObject;
		private var mBtnSystem:SimpleButton;
		private var mPowerPanel:Sprite;
		
		public function Application(root:Sprite)
		{
			if(application) throw "Application为单例！";
			mSandBox = new SandBox();
			mDriver = new Driver(mSandBox);
			mRoot = root;
			mPluginQueue = new <IPlugin>[];
			mPluginsInRun = new <IPlugin>[];
			
			mLoadingBar = new LoadingBar() as DisplayObject;
			mLoadingBar.x = root.stage.stageWidth * .5;
			mLoadingBar.y = root.stage.stageHeight * .5;
			root.addChild(mLoadingBar);
			
			mBtnSystem = new SystemBtn() as SimpleButton;
			mBtnSystem.y = mBtnSystem.height * .5;
			mBtnSystem.x = root.stage.stageWidth - mBtnSystem.width * .5;
			mBtnSystem.name = "btnSystem";
			root.stage.addChild(mBtnSystem);
			mBtnSystem.addEventListener(MouseEvent.CLICK,onClick);
			
			mPowerPanel = new McApplicationPower() as Sprite;
			mPowerPanel.x = root.stage.stageWidth * .5;
			mPowerPanel.y = root.stage.stageHeight * .5;
			mPowerPanel.addEventListener(MouseEvent.CLICK,onClick);
			
			mRoot.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			
			application = this;
			
		}
		
		private function onClick(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "btnSystem":
					if(mRoot.contains(mPowerPanel)) return;
					mRoot.addChild(mPowerPanel);
					break;
				case "btnRestart":
					mRoot.removeChild(mPowerPanel);
//					restart();
					break;
				case "btnStop":
					mRoot.removeChild(mPowerPanel);
//					exit();
					break;
				case "btnOff":
					break;
				case "btnCancel":
					mRoot.removeChild(mPowerPanel);
					break;
			}
		}
		
		private function onEnterFrame(e:Event):void
		{
			for(var i:int=0;i<mPluginsInRun.length;++i)
			{
				if(mPluginsInRun)
					mPluginsInRun[i].update();
			}
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
			mPluginQueue.push(plugin);
			checkForExecute();
		}
		
		private function onPluginFinished(e:PluginEvent):void
		{
			var pluginInfo:PluginInfo = e.pluginInfo;
			
			var index:uint = pluginInfo.thread;
			mPluginsInRun[index].removeEventListener(PluginEvent.PLUGIN_FINISHED,onPluginFinished);
			mPluginsInRun[index].dispose();
			mPluginsInRun.splice(index,1);
			
			uninstall(pluginInfo);
			
			checkForExecute();
		}
		
		private function checkForExecute():void
		{
			while(mPluginQueue.length)
			{
				var lastThread:int = mPluginsInRun.length - 1;
				if(lastThread<mPluginQueue[0].info.thread)
				{
					var plugin:IPlugin = mPluginQueue.shift();
					mPluginsInRun.push(plugin);
					plugin.addEventListener(PluginEvent.PLUGIN_FINISHED,onPluginFinished);
					plugin.execute(root);
				}
				else
				{
					break;
				}
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