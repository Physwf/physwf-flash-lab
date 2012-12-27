package com.physwf.application.login.view
{
	import com.physwf.application.interfaces.IDestroyable;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Loading extends Sprite
	{
		public static var MAIN_LOADING:DisplayObject;
		public static var LIGHT_LOADING:DisplayObject;
		
//		[Embed(source="source")]
		private static var MainLoading:Class;
		
//		[Embed(source="source")]
		private static var LightLoading:Class;
		
		public function Loading()
		{
			super();
		}
		
		public static function initialize():void
		{
			MAIN_LOADING = new MainLoading() as DisplayObject;
			LIGHT_LOADING = new LightLoading() as DisplayObject;
			MainLoading = null;
			LightLoading = null;
		}
		
		public static function showMainLoading(root:Sprite):void
		{
			
		}
		
		public static function removeMainLoading():void
		{
			
		}
	}
}