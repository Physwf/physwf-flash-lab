package com.physwf.shell 
{
	import com.physwf.shell.events.DriverEvent;
	import com.physwf.shell.events.ScriptEvent;
	import com.physwf.shell.parser.CustomParser;
	import com.physwf.shell.parser.IParser;
	import com.physwf.shell.parser.XMLParser;
	import com.physwf.shell.plugin.IPlugin;
	import com.physwf.shell.plugin.PluginEvent;
	import com.physwf.shell.plugin.PluginInfo;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	/**
	 * 驱动器 
	 * @author joe
	 * 
	 */	
	public class Driver extends EventDispatcher
	{
		public static const SCRIPT_XML:int = 0;
		public static const SCRIPT_CUSTUM:int = 1;
		
		private var mSandBox:SandBox;//该沙箱为Driver所属的Application的沙箱
		private var mLoadQueue:Vector.<PluginInfo>;//加载队列
		private var mNextLoadItem:PluginInfo;
		
		private var mIsRuning:Boolean;
		
		
		
		public function Driver(sandBox:SandBox)
		{
			mSandBox = sandBox;
			mLoadQueue = new <PluginInfo>[];
			mIsRuning = false;
		}
		/**
		 * 加载驱动配置脚本 
		 * @param url
		 * @param scriptType 脚本类型
		 * 
		 */		
		public function loadScript(url:String,scriptType:int=0):void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,onScriptComplete);
			var request:URLRequest = new URLRequest(url);
			urlLoader.dataFormat =SCRIPT_XML? URLLoaderDataFormat.BINARY: URLLoaderDataFormat.TEXT;
			urlLoader.load(request);
		}
		
		private function onScriptComplete(e:Event):void
		{
			var urlLoader:URLLoader = URLLoader(e.target);
			var data:*;
			var parser:IParser;
			var name:String;
			if(urlLoader.dataFormat == URLLoaderDataFormat.TEXT)
			{
				data = XML(urlLoader.data);
				parser = new XMLParser();
				name = data.@name;
			}
			else if(urlLoader.dataFormat == URLLoaderDataFormat.BINARY)
			{
				data = urlLoader.data;
				parser = new CustomParser();
				//name =???;
			}
			var pluginPack:Vector.<PluginInfo> = parser.parse(data);
			mLoadQueue = mLoadQueue.concat(pluginPack);
			dispatchEvent(new ScriptEvent(ScriptEvent.SCRIPT_LOADED,{name:name}));
		}
		
		public function start():void
		{
			if(mIsRuning) return;
			mIsRuning = true;
			if(!mNextLoadItem && mLoadQueue.length) mNextLoadItem = mLoadQueue.shift();
			dispatchEvent(new DriverEvent(DriverEvent.DRIVER_AVALIABLE,null))
		}
		
		public function get isRuning():Boolean
		{
			return mIsRuning;	
		}
		
		public function stop():void
		{
			mIsRuning = false;
		}
		
		public function get nextLoadItem():PluginInfo
		{
			return mNextLoadItem;
		}
		
		public function load(pluginInfo:PluginInfo,domain:ApplicationDomain):void
		{
			var loader:Loader = new Loader();
			var application:Application = Application.application;
			var onLoaded:Function = function (e:Event):void
			{
				sHelpCount++;
				if(pluginInfo.type=="exe")
				{
					var plugin:IPlugin = loader.content as IPlugin;
					plugin.info = pluginInfo;
					loader.unload();
					application.registerPlugin(pluginInfo,plugin);
					plugin.dispatchEvent(new PluginEvent(PluginEvent.PLUGIN_INSTALLED,pluginInfo));
				}
				else if(pluginInfo.type=="dll")
				{
					loader.unloadAndStop(true);
				}
				
				if(mIsRuning) mNextLoadItem = mLoadQueue.shift();
				else mNextLoadItem = null;
				if(mLoadQueue.length<=0) stop();
				dispatchEvent(new DriverEvent(DriverEvent.DRIVER_AVALIABLE,null));
			};
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
			trace(pluginInfo.url);
			loader.load(new URLRequest(pluginInfo.url),new LoaderContext(false,domain));
		}
		
		private var sHelpCount:int;
		private function onProgress(e:ProgressEvent):void
		{
			var curProgress:Number = e.bytesLoaded/e.bytesTotal;
			dispatchEvent(new DriverEvent(DriverEvent.DRIVER_PROGRESS,(sHelpCount+curProgress)/(sHelpCount+mLoadQueue.length+1)));
		}
		
		public function dispose():void
		{
			mSandBox = null;
			mLoadQueue = null;
			mNextLoadItem = null;
		}
	}
}