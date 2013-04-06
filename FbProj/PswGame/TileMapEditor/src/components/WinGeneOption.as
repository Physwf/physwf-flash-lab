package components
{
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import com.bit101.components.Window;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	public class WinGeneOption extends EventDispatcher
	{
		private var mLayer:Sprite;
		private var winOption:Window;
		private var optionJPG:RadioButton;
		private var optionPNG:RadioButton;
		private var optionDEF:RadioButton;
		private var btnOk:PushButton;
		
		public function WinGeneOption(layer:Sprite)
		{
			mLayer = layer;
			
			winOption = new Window();
			winOption.title = "Option";
			winOption.width = 300;
			winOption.height = 70;
			
			optionJPG = new RadioButton(winOption);
			optionJPG.label = "JPG";
			optionJPG.x = 30;
			optionJPG.y = 20;
			optionPNG = new RadioButton(winOption);
			optionPNG.label = "PNG";
			optionPNG.x = 80;
			optionPNG.y = 20;
			optionDEF = new RadioButton(winOption);
			optionDEF.label = "Deflate"
			optionDEF.x = 130;
			optionDEF.y = 20;
			
			btnOk = new PushButton(winOption);
			btnOk.label = "ok";
			btnOk.width = 60;
			btnOk.x = 200;
			btnOk.y = 15;
		}
		
		public function show():void
		{
			mLayer.addChild(winOption);
			optionJPG.selected = true;
			winOption.x = (mLayer.stage.stageWidth - winOption.width) * .5;
			winOption.y = (mLayer.stage.stageHeight - winOption.height) * .5;
			btnOk.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		public function hide():void
		{
			mLayer.removeChild(winOption);
			btnOk.removeEventListener(MouseEvent.CLICK,onClick);
		}
		
		private function onClick(e:MouseEvent):void
		{
			dispatchEvent(new Event("ok"));
		}
		
		public function get option():String
		{
			if(optionJPG.selected) return "jpg";
			if(optionPNG.selected) return "png";
			return "deflate";
		}
	}
}