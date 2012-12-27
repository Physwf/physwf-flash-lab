package com.physwf.application.login.view
{
	import com.physwf.application.interfaces.IDestroyable;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	
	public class PanelBase extends Sprite implements IDestroyable
	{
		public function PanelBase(assetName:String)
		{
			var Asset:Class = ApplicationDomain.currentDomain.getDefinition(assetName) as Class;
			var asset:Object = new Asset();
			addChild(asset as DisplayObject);
			addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onClick(e:MouseEvent):void
		{
			throw "抽象方法，由子类实现！";
		}
		
		public function dispose():void
		{
			removeChildAt(0);
			removeEventListener(MouseEvent.CLICK,onClick);
		}
	}
}