package com.physwf.application.login.view
{
	import com.physwf.application.interfaces.IDestroyable;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Loading
	{
		public static var MAIN_LOADING:DisplayObject;
		public static var LIGHT_LOADING:DisplayObject;
		
		[Embed(source="../assets/LoginEmbed.swf",symbol="McLoginMainLoading")]
		private static var MainLoading:Class;
		
		[Embed(source="../assets/LoginEmbed.swf",symbol="McLoginLightLoading")]
		private static var LightLoading:Class;
		
		public function Loading()
		{
			super();
		}
		
		public static function initialize():void
		{
			MAIN_LOADING = new MainLoading() as DisplayObject;
			LIGHT_LOADING = new LightLoading() as DisplayObject;
			
			MAIN_LOADING.x = 500;
			MAIN_LOADING.y = 300;
			
			LIGHT_LOADING.x= 500;
			LIGHT_LOADING.y= 300;
			
			
			
			MainLoading = null;
			LightLoading = null;
		}
		
		public static function showMainLoading(root:Sprite):void
		{
			MAIN_LOADING.addEventListener(Event.ENTER_FRAME,function(e:Event) :void
			{
				MAIN_LOADING["c1"].rotation +=2;
				MAIN_LOADING["c2"].rotation +=2;
				MAIN_LOADING["c3"].rotation -=4;
				MAIN_LOADING["c4"].rotation -=4;
			},false,0,true);
			
			root.addChild(MAIN_LOADING);
		}
		
		public static function removeMainLoading(root:Sprite):void
		{
			root.removeChild(MAIN_LOADING);
		}
		
		public static function showLightLoading(root:Sprite):void
		{
			LIGHT_LOADING.addEventListener(Event.ENTER_FRAME,function(e:Event) :void
			{
				LIGHT_LOADING["c1"].rotation +=2;
				LIGHT_LOADING["c2"].rotation -=1.5;
			},false,0,true);
			
			root.addChild(LIGHT_LOADING);
		}
		
		public static function removeLightLoading(root:Sprite):void
		{
			root.removeChild(LIGHT_LOADING);
		}
	}
}