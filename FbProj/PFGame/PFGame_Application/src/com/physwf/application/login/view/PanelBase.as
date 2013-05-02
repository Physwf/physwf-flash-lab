package com.physwf.application.login.view
{
	import com.physwf.shell.interfaces.IDestroyable;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	
	public class PanelBase extends Sprite implements IDestroyable
	{
		protected var asset:DisplayObject;
		
		public function PanelBase(assetName:String)
		{
			var Asset:Class = ApplicationDomain.currentDomain.getDefinition(assetName) as Class;
			asset = new Asset() as DisplayObject;
			addChild(asset);
			addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onClick(e:MouseEvent):void
		{
			throw "抽象方法，由子类实现！";
		}
		
		public function dispose():void
		{
			removeChild(asset);
			asset = null;
			removeEventListener(MouseEvent.CLICK,onClick);
		}
	}
}