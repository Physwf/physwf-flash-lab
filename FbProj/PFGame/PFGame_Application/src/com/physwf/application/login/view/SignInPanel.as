package com.physwf.application.login.view
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	public class SignInPanel extends PanelBase
	{
		public var onSignIn:Function;
		public var onRegister:Function;
		public var onCancel:Function;
		
		public function SignInPanel(assetName:String)
		{
			super(assetName);
			asset.x = 500;
			asset.y = 250;
			TextField(asset["txtPassword"]).displayAsPassword = true;
			asset["txtUID"].text = "1000000";
			asset["txtPassword"].text = "142857";
		}
		
		override protected function onClick(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "btnSignIn":
					onSignIn();
					break;
				case "btnCancel":
					onCancel();
					break;
			}
		}
		
		public function get userID():String
		{
			return asset["txtUID"].text;
		}
		
		public function get password():String
		{
			return asset["txtPassword"].text;
		}
		
		override public function dispose():void
		{
			super.dispose();
			onSignIn = null;
			onRegister = null;
			onCancel = null;
		}
	}
}