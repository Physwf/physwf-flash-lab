package com.physwf.application.debug.console
{
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.engine.Engine;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextInteractionMode;
	import flash.ui.Keyboard;
	
	public class ConsoleInput extends Sprite
	{
		private var txtInput:TextField;
		private var mRoot:Sprite;
		
		public function ConsoleInput(root:Sprite)
		{
			mRoot = root;
			txtInput = new TextField();
			var tf:TextFormat = new TextFormat("Courier New",13,0xFFFFFF);
			txtInput.defaultTextFormat = tf;
			txtInput.type = TextFieldType.INPUT;
			txtInput.multiline = true;
			addChild(txtInput);
			drawBg();
		}
		
		public function drawBg():void
		{
			graphics.clear();
			graphics.beginFill(0x0,0.8);
			graphics.drawRect(0,0,300,mRoot.stage.stageHeight);
			txtInput.width = 300;
			txtInput.height = mRoot.stage.stageHeight;
			graphics.endFill();
		}
		
		public function appendText(s:String):void
		{
			txtInput.appendText(s);
		}
		
		public function set text(s:String):void
		{
			txtInput.text = s;
		}
		
		public function get text():String
		{
			return txtInput.text;
		}
		
		public function clear():void
		{
			txtInput.text = "";
		}
		
		public function show():void
		{
			txtInput.addEventListener(KeyboardEvent.KEY_UP,onKeyDown);
			if(!ScreenManager.main.frame.contains(this))
			{
				ScreenManager.main.frame.addChild(this);
			}
		}
		
		public function hide():void
		{
			txtInput.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.ENTER)
			{
				var lines:String = text;
				lines = lines.replace(/\r|\n/g,"");// filter /r /n
				var cmds:Array = lines.split(";");
				var lastLine:String = cmds[cmds.length-2];
				if(lastLine == null) return;
				Command.parse(lastLine);
			}
		}
	}
}