package components
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ToolIcon extends Sprite
	{
		public static var dir_icon_assets:String;
		public var dir:String;
		
		private var label:TextField;
		
		public function ToolIcon(name:String)
		{
//			graphics.beginFill(0xFFFFFF * Math.random());
//			graphics.drawRect(0,0,70,70);
//			graphics.endFill();
			buttonMode = true;
			this.name = name;
			label = new TextField();
			label.selectable = false;
			label.mouseEnabled = false;
			var tf:TextFormat = new TextFormat("Consolas",12,0,true);
			label.defaultTextFormat = tf;
			label.text = name;
			label.autoSize = "center"
			addChild(label);
			label.y = 20;
			label.x = - label.width * .5;
			loadAsset();
		}
		
		private function loadAsset():void
		{
			var loader:Loader = new Loader();
			function onComplete(e:Event):void
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
				var asset:DisplayObject = loader.content;
				asset.x = - asset.width * .5;
				asset.y = - asset.height * .5;
				addChildAt(asset,0);
			};
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.load(new URLRequest(dir_icon_assets+name+".png"));
		}
	}
}