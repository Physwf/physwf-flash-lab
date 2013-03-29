package components
{
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import com.bit101.components.Window;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import shinater.swing.Button;
	import shinater.swing.TextInput;

	public class WinNewMap extends EventDispatcher
	{
		private var mLayer:Sprite;
		private var winNewMap:Window;
		private var input:Text;
		private var btnOk:PushButton;
		
		public function WinNewMap(layer:Sprite)
		{
			mLayer = layer;
			
			winNewMap ||= new Window();
			
			winNewMap.width = 300;
			winNewMap.height = 70;
			
			input = new Text();
			input.x = 50;
			input.y = 10;
			input.width = 100;
			input.height = 20;
			
			winNewMap.addChild(input);
			
			btnOk = new PushButton();
			btnOk.x = 180;
			btnOk.y = 10;
			btnOk.width = 60;
			btnOk.label = "ok";
			winNewMap.addChild(btnOk);
			
		}
		
		public function show():void
		{
			mLayer.addChild(winNewMap);
			winNewMap.x = (mLayer.stage.stageWidth - winNewMap.width) * .5;
			winNewMap.y = (mLayer.stage.stageHeight - winNewMap.height) * .5;
			btnOk.addEventListener(MouseEvent.CLICK,onOk);
			input.addEventListener(Event.CHANGE,onTextChange);
			onTextChange(null);
		}
		
		public function hide():void
		{
			mLayer.removeChild(winNewMap);
			btnOk.removeEventListener(MouseEvent.CLICK,onOk);
			input.removeEventListener(Event.CHANGE,onTextChange);
		}
		
		public function get inputContent():String
		{
			return input.textField.text;
		}
		
		private function onOk(e:MouseEvent):void
		{
			dispatchEvent(new Event("ok"));
		}
		
		private function onTextChange(e:Event):void
		{
			input.text = input.text.replace(/\s/g,"");
			if(input.text == "")
			{
				btnOk.enabled = false;
			}
			else
			{
				btnOk.enabled = true;
			}
		}
	}
}