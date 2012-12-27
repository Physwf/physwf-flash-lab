package com.physwf.application.login
{
	import com.physwf.application.interfaces.IDestroyable;
	import com.physwf.application.login.cache.LoginContext;
	import com.physwf.application.login.services.LoginService;
	import com.physwf.application.login.view.Loading;
	import com.physwf.application.login.view.SignInPanel;
	import com.physwf.application.login.view.StartPanel;
	import com.physwf.system.entity.MyInfo;
	import com.physwf.system.vo.LoginInfo;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * 登陆模块为
	 * @author joe
	 * 
	 */	
	public class Login implements IDestroyable
	{
		private var mRoot:Sprite;
		
		public function Login(root:Sprite)
		{
			mRoot = root;
		}
		
		public function initialize():void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,onConfigLoaded);
			urlLoader.load(new URLRequest("config/server.xml"));
			//登陆服务和登陆环境初始化
			LoginService.instance.initialize();
			LoginContext.initialize();
		}
		
		private function onConfigLoaded(e:Event):void
		{
			var urlLoader:URLLoader = URLLoader(e.target);
			urlLoader.removeEventListener(Event.COMPLETE,onConfigLoaded);
			var serverConfig:XML = XML(urlLoader.data);
			var loginInfo:LoginInfo = new LoginInfo();
			// 产品信息
			LoginContext.setProductInfo(serverConfig.pid,serverConfig.pname);
			
			loginInfo.host = serverConfig.ip[0].host;
			loginInfo.port = uint(serverConfig.ip[0].port);
			
			MyInfo.loginInfo = loginInfo;
			loadAssets();
		}
		
		private function loadAssets():void
		{
			Loading.initialize();
			Loading.showMainLoading(mRoot);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onAssetsLoaded);
			//loader.load()//需要制定ApplicationDomain吗？
		}
		
		private function onAssetsLoaded(e:Event):void
		{
			var loader:Loader = e.target as Loader;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onAssetsLoaded);
			loader.unloadAndStop(true);
			Loading.removeMainLoading();
			
			var startPanel:StartPanel = new StartPanel("StartAsset");
			startPanel.onStartClick = function ():void
			{
				mRoot.removeChild(startPanel);
				startPanel.dispose();
				stepSignIn();
			};
			mRoot.addChild(startPanel);
		}
		
		private function stepSignIn():void
		{
			var signInPanel:SignInPanel = new SignInPanel("SignInAsset");
			signInPanel.onSignIn = function():void
			{
//				mRoot.removeChild(signInPanel);
				MyInfo.loginInfo.userID = signInPanel.userID;
				MyInfo.loginInfo.password = signInPanel.password;
				mRoot.addChild(Loading.LIGHT_LOADING);
				LoginService.instance.login(MyInfo.loginInfo.userID,MyInfo.loginInfo.password);
			};
			signInPanel.onRegister = function():void
			{
				mRoot.removeChild(signInPanel);
				stepRegister();
			};
			mRoot.addChild(signInPanel);
		}
		
		private function stepRegister():void
		{
			
		}
		
		public function dispose():void
		{
			Loading.MAIN_LOADING = null;
			Loading.LIGHT_LOADING = null;
		}	
	}
}