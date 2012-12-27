package  {
	import flash.display.*;
	import flash.net.URLRequest;
	import flash.text.*;
	import flash.events.Event;
	import flash.system.*;
	import flash.utils.*;
	
	public class FontEmbedTest extends Sprite{

		private var loader:Loader;
		
		public function FontEmbedTest() {
			loader = new Loader();
			loader.load(new URLRequest("FontEmbed.swf"),new LoaderContext(false,ApplicationDomain.currentDomain))
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
		}
		
		private function onComplete(e:Event):void
		{
			var Broadway:Class =  getDefinitionByName("Broadway") as Class;
			Font.registerFont(Broadway);
			var bf:Font = new Broadway() as Font;
			var tf:TextField = new TextField();
			var tfo:TextFormat = new TextFormat(bf.fontName,12);
			
			tf.defaultTextFormat = tfo;
			tf.embedFonts = true;
			tf.text = "sample";
			addChild(tf);
		}

	}
	
}
